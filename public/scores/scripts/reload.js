/*
 * author: Shuya Fuchigami, 554092
 *
 * when page loaded, contents of tables are also loaded.
 * and the renew itself every 3 seconds.
 *
 */

window.addEventListener('load', function () {
  updateTopScoreTable();
  updateNewestScoreTable();
});


//reload whole page
/*
function doReloadIgnoreCache() {
window.location.reload(true);
}
*/

//automatic reloading for 3000ms
setInterval(function(){
  updateTopScoreTable();
  updateNewestScoreTable();
}, 30000);


//function for debug
function updateTable(){
  updateTopScoreTable();
  updateNewestScoreTable();
}


Object.defineProperty(this, 'updateTopScoreTable', {
  enumerable: false,
  configurable: false,
  value: async function() {

    let highScoreTop3 = document.getElementById("highScoreTop3");
    let top1Name = highScoreTop3.rows[0].cells[1].firstChild;
    let top1Score = highScoreTop3.rows[0].cells[2].firstChild;
    let top2Name = highScoreTop3.rows[1].cells[1].firstChild;
    let top2Score = highScoreTop3.rows[1].cells[2].firstChild;
    let top3Name = highScoreTop3.rows[2].cells[1].firstChild;
    let top3Score = highScoreTop3.rows[2].cells[2].firstChild;
    let highScore10 = document.getElementById("highScore10");
    let highScoreAfter11 = document.getElementById("highScoreAfter11");

    //delete all old rows
    while(0<highScoreAfter11.rows.length){
      highScoreAfter11.deleteRow(0);
    }

    try {
      //fetch top score json from server
      const result = await this.getTopScores();

      //for 1. table in top scores
      top1Name.innerHTML = result[0].player;
      top1Score.innerHTML = result[0].score;
      top2Name.innerHTML = result[1].player;
      top2Score.innerHTML = result[1].score;
      top3Name.innerHTML = result[2].player;
      top3Score.innerHTML = result[2].score;

      // for 2. table in top scores
      // +4 for table, +3 for json
      for(let i=0; i<7; i++){
        let number = highScore10.rows[i].cells[0].firstChild;
        let name = highScore10.rows[i].cells[1].firstChild;
        let score = highScore10.rows[i].cells[2].firstChild;
        number.innerHTML = i+4;
        name.innerHTML = result[i+3].player;
        score.innerHTML = result[i+3].score;
      }

      // for 3. table in top scores
      // +10 for json
      for (var i=10; i<result.length; i++){
        // add new row
        let highScoreAfter11Row = highScoreAfter11.insertRow(-1);

        const thLeft = document.createElement('th');
        const h3Left = document.createElement('h3');
        h3Left.className = "left padding";
        h3Left.innerHTML = (i+1) + ".";
        thLeft.appendChild(h3Left);
        highScoreAfter11Row.appendChild(thLeft);

        const thCenter = document.createElement('th');
        const h3Center = document.createElement('h3');
        h3Center.className = "left padding padding-left";
        h3Center.innerHTML = result[i].player;
        thCenter.appendChild(h3Center);
        highScoreAfter11Row.appendChild(thCenter);

        const thRight = document.createElement('th');
        const h3Right = document.createElement('h3');
        h3Right.className = "right padding";
        h3Right.innerHTML = result[i].score;
        thRight.appendChild(h3Right);
        highScoreAfter11Row.appendChild(thRight);
      }

    } catch (error) {
      console.log(error);
    }
  }
});


Object.defineProperty(this, 'updateNewestScoreTable', {
  enumerable: false,
  configurable: false,
  value: async function() {

    let newestScoresTop3 = document.getElementById("newestScoresTop3");
    let top1Rank = newestScoresTop3.rows[0].cells[0].firstChild;
    let top1Name = newestScoresTop3.rows[0].cells[1].firstChild;
    let top1Score = newestScoresTop3.rows[0].cells[2].firstChild;

    let top2Rank = newestScoresTop3.rows[1].cells[0].firstChild;
    let top2Name = newestScoresTop3.rows[1].cells[1].firstChild;
    let top2Score = newestScoresTop3.rows[1].cells[2].firstChild;

    let top3Rank = newestScoresTop3.rows[2].cells[0].firstChild;
    let top3Name = newestScoresTop3.rows[2].cells[1].firstChild;
    let top3Score = newestScoresTop3.rows[2].cells[2].firstChild;
    let newestScore10 = document.getElementById("newestScore10");
    let newestScoreAfter11 = document.getElementById("newestScoreAfter11");

    //delete all old rows
    while(0<newestScoreAfter11.rows.length){
      newestScoreAfter11.deleteRow(0);
    }

    try {
      //fetch top score json from server
      const result = await this.getNewestScores();

      console.log(result);
      console.log(top1Rank);

      //for 1. table in top scores
      top1Rank.innerHTML = result[0].rank;
      top1Name.innerHTML = result[0].player;
      top1Score.innerHTML = result[0].score;

      top2Rank.innerHTML = result[1].rank;
      top2Name.innerHTML = result[1].player;
      top2Score.innerHTML = result[1].score;

      top3Rank.innerHTML = result[2].rank;
      top3Name.innerHTML = result[2].player;
      top3Score.innerHTML = result[2].score;


      // for 2. table in top scores
      // +4 for table, +3 for json
      for(let i=0; i<7; i++){
        let number = newestScore10.rows[i].cells[0].firstChild;
        let name = newestScore10.rows[i].cells[1].firstChild;
        let score = newestScore10.rows[i].cells[2].firstChild;
        number.innerHTML = result[i+3].rank;
        name.innerHTML = result[i+3].player;
        score.innerHTML = result[i+3].score;
      }

      // for 3. table in top scores
      // +10 for json
      for (var i=10; i<result.length; i++){
        // add new row
        let newestScoreAfter11Row = newestScoreAfter11.insertRow(-1);

        const thLeft = document.createElement('th');
        const h3Left = document.createElement('h3');
        h3Left.className = "left padding";
        h3Left.innerHTML = result[i].rank; + ".";
        thLeft.appendChild(h3Left);
        newestScoreAfter11Row.appendChild(thLeft);

        const thCenter = document.createElement('th');
        const h3Center = document.createElement('h3');
        h3Center.className = "left padding padding-left";
        h3Center.innerHTML = result[i].player;
        thCenter.appendChild(h3Center);
        newestScoreAfter11Row.appendChild(thCenter);

        const thRight = document.createElement('th');
        const h3Right = document.createElement('h3');
        h3Right.className = "right padding";
        h3Right.innerHTML = result[i].score;
        thRight.appendChild(h3Right);
        newestScoreAfter11Row.appendChild(thRight);
      }

    } catch (error) {
      console.log(error);
    }
  }
});


Object.defineProperty(this, 'getTopScores', {
  enumerable: false,
  configurable: false,
  value: async function() {
    const resource = "/scores_desc";

    let response = await fetch(resource, { method: 'GET', headers: {"Accept": "application/json"} } );
    if (!response.ok) throw new Error(response.status + ' ' + response.statusText);

    const result = await response.json();
    return result;
  }
});


Object.defineProperty(this, 'getNewestScores', {
  enumerable: false,
  configurable: false,
  value: async function() {
    const resource = "/scores_updated_at_desc_with_ranking";

    let response = await fetch(resource, { method: 'GET', headers: {"Accept": "application/json"} } );
    if (!response.ok) throw new Error(response.status + ' ' + response.statusText);

    const result = await response.json();
    return result;
  }
});
