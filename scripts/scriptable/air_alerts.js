/**
 * Displays the air raid alert status and last successful check time for
 * Cherkasy District (UID 152) in a small circular iOS Lock Screen widget.
 * Prompts for an alerts.in.ua API token on first run and stores it in Keychain.
 * Requests a refresh after 60 seconds. iOS controls the actual refresh timing.
 *
 * @see https://devs.alerts.in.ua/#apiiot_active_air_raid_alerts_v2_uid
 * @see https://docs.scriptable.app/listwidget/
 */

const REGION_UID = 152; // Черкаський район
const TOKEN_KEY = "alerts.in.ua.widget.token";

const states = {
  R: { label: "Черв.", icon: "exclamationmark.triangle.fill" },
  Y: { label: "Жовт.", icon: "exclamationmark.circle" },
  P: { label: "Частк.", icon: "circle.lefthalf.fill" },
  N: { label: "Немає", icon: "checkmark.circle" },
  unknown: { label: "Невід.", icon: "questionmark.circle" },
};

async function askForToken() {
  const dialog = new Alert();
  dialog.title = "Токен alerts.in.ua";
  dialog.addSecureTextField("API-токен", "");
  dialog.addAction("Зберегти");
  dialog.addCancelAction("Скасувати");

  if (await dialog.presentAlert() === -1) return "";

  const token = dialog.textFieldValue(0).trim();
  if (token) Keychain.set(TOKEN_KEY, token);
  return token;
}

async function checkStatus(token) {
  if (!token) {
    return { code: "unknown", error: "Введи API-токен у Scriptable." };
  }

  const request = new Request(
    `https://api.alerts.in.ua/v2/iot/active_air_raid_alerts/${REGION_UID}.json`
  );
  request.headers = {
    Authorization: `Bearer ${token}`,
    Accept: "application/json",
  };
  request.timeoutInterval = 8;

  try {
    const body = await request.loadString();
    if (request.response?.statusCode !== 200) {
      return {
        code: "unknown",
        error: `Помилка API (${request.response?.statusCode ?? "без відповіді"}).`,
      };
    }

    const code = JSON.parse(body);
    if (!["R", "Y", "P", "N"].includes(code)) {
      return { code: "unknown", error: "Невідома відповідь API." };
    }

    return { code, checkedAt: new Date() };
  } catch {
    return { code: "unknown", error: "Не вдалося перевірити статус." };
  }
}

let token = Keychain.contains(TOKEN_KEY) ? Keychain.get(TOKEN_KEY) : "";
if (!token && config.runsInApp) token = await askForToken();

let status = await checkStatus(token);
if (config.runsInApp && status.error === "Помилка API (401).") {
  const replacement = await askForToken();
  if (replacement) status = await checkStatus(replacement);
}
if (config.runsInApp && status.error) {
  const dialog = new Alert();
  dialog.title = "Черкаський район";
  dialog.message = status.error;
  dialog.addAction("OK");
  await dialog.presentAlert();
}

const state = states[status.code];
const widget = new ListWidget();
widget.addAccessoryWidgetBackground = true;
widget.setPadding(0, 0, 0, 0);
widget.refreshAfterDate = new Date(Date.now() + 60_000);
widget.url = URLScheme.forRunningScript();

widget.addSpacer();
const icon = widget.addImage(SFSymbol.named(state.icon).image);
icon.imageSize = new Size(17, 17);
icon.centerAlignImage();
widget.addSpacer(2);

const label = widget.addText(state.label);
label.font = Font.boldSystemFont(11);
label.lineLimit = 1;
label.centerAlignText();
widget.addSpacer(2);

const clock = new DateFormatter();
clock.dateFormat = "HH:mm";
const time = widget.addText(status.checkedAt ? clock.string(status.checkedAt) : "—");
time.font = Font.mediumSystemFont(9);
time.centerAlignText();
widget.addSpacer();

if (config.runsInWidget) {
  Script.setWidget(widget);
} else if (config.runsInApp) {
  await widget.presentAccessoryCircular();
}
Script.complete();
