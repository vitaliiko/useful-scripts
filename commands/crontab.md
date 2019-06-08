#### Every 15 minutes except for 3:00-3:59
```
*/15 0-2,4-23 * * * thejob
```
#### At 3:15, 3:30 and 3:45
```
15-45/15 3 * * * thejob
```
#### At 3:00
```
0 3 * * * otherjob
```
