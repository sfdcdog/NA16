.processListLabel{
    font-weight: bold;
    font-size: 16px;
    text-shadow: 3px 3px 10px #708090;
}
.processList{
    font-size: 16px;
    width: 150px;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    text-align: center;
    box-sizing: border-box;
}
.caseslctTable{
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    border: 50px solid black;
}
.btnStyle:hover{
	/*background-color: #3e8e41;*/
	background: -webkit-linear-gradient(90deg, #FD6F46 10%, #FB9832 90%);
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    border-radius: 20px;
    font-weight: bold;
}
.btnStyle:active{
    background-color: #3e8e41;
    box-shadow: 0 5px #666;
    transform: translateY(4px);
    border-radius: 520px;
    font-weight: bold;
}
.csRowStyle{
    color: white;
    font-weight: bold;
    border: 10px solid black;
    transition: font-weight .3s, font-size .3s;
    transition-timing-function: ease-in-out;
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 4px 10px 0 rgba(0, 0, 0, 0.19);
}
.csRowStyle:hover{
    
    font-weight: bold;
    font-size: 15px;
    text-shadow: 3px 3px 10px #708090;
    border: 10px solid black;
    background: -webkit-linear-gradient(90deg, #b6eae1 10%, #D2FBAD 90%);
    /*background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);*//*CSS3 Gradients*/
    opacity: .90;/*CSS3 Gradients*/
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 4px 10px 0 rgba(0, 0, 0, 0.19);
}



.chkbxStyle:hover{
	background: -webkit-linear-gradient(90deg, #01a99c 10%, #0698b1 90%);
	opacity: 1.2;
	box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.2), 0 4px 8px 0 rgba(0, 0, 0, 0.19);
	width: 20px;
	height: 20px;
}

.headerRow{
	font-weight: bold;
    border: 10px solid black;
    transition: font-weight .1s, font-size .1s;
    transition-timing-function: ease-in-out;
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 4px 10px 0 rgba(0, 0, 0, 0.19);
}
.headerRow:hover{
    font-weight: bold;
    font-size: 15px;
    text-shadow: 3px 3px 10px #708090;
    border: 10px solid black;
    background:linear-gradient(90deg, #b6eae1 10%, #D2FBAD 90%);
    /*background: linear-gradient(141deg, #0fb8ad 0%, #1fc8db 51%, #2cb5e8 75%);*//*CSS3 Gradients*/
    opacity: 1.50;/*CSS3 Gradients*/
    box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 4px 10px 0 rgba(0, 0, 0, 0.19);
}


/*SWITCHER BUTTON*/
.switch {
	position: relative;
	display: block;
	vertical-align: top;
	width: 54px;
	height: 12px;
	padding: 3px;
	margin: 0 10px 10px 0;
	background: linear-gradient(to bottom, #eeeeee, #FFFFFF 25px);
	background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF 25px);
	border-radius: 18px;
	box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.2), 0 4px 10px 0 rgba(0, 0, 0, 0.19);
	cursor: pointer;
	box-sizing:content-box;
}
.switch-input {
	position: absolute;
	top: 0;
	left: 0;
	opacity: 0;
	box-sizing:content-box;
}
.switch-label {
	position: relative;
	display: block;
	height: inherit;
	font-size: 10px;
	text-transform: uppercase;
	background: #eceeef;
	border-radius: inherit;
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.12), inset 0 0 2px rgba(0, 0, 0, 0.15);
	box-sizing:content-box;
}
.switch-label:before, .switch-label:after {
	position: absolute;
	top: 50%;
	margin-top: -.5em;
	line-height: 1;
	-webkit-transition: inherit;
	-moz-transition: inherit;
	-o-transition: inherit;
	transition: inherit;
	box-sizing:content-box;
}
.switch-label:before {
	content: attr(data-off);
	right: 11px;
	color: #aaaaaa;
	text-shadow: 0 1px rgba(255, 255, 255, 0.5);
}
.switch-label:after {
	content: attr(data-on);
	left: 11px;
	color: #FFFFFF;
	text-shadow: 0 1px rgba(0, 0, 0, 0.2);
	opacity: 0;
}
.switch-input:checked ~ .switch-label {
	background: #E1B42B;
	box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.15), inset 0 0 3px rgba(0, 0, 0, 0.2);
}
.switch-input:checked ~ .switch-label:before {
	opacity: 0;
}
.switch-input:checked ~ .switch-label:after {
	opacity: 1;
}
.switch-handle {
	color: red;
	position: absolute;
	top: 4px;
	left: 4px;
	width: 4px;
	height: 10px;
	background: linear-gradient(to bottom, #FFFFFF 40%, #f0f0f0);
	background-image: -webkit-linear-gradient(top, #FFFFFF 40%, #f0f0f0);
	border-radius: 100%;
	box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.2);
}
.switch-handle:before {
	content: "";
	position: absolute;
	top: 50%;
	left: 50%;
	margin: -6px 0 0 -6px;
	width: 12px;
	height: 12px;
	background: linear-gradient(to bottom, #eeeeee, #FFFFFF);
	background-image: -webkit-linear-gradient(top, #eeeeee, #FFFFFF);
	border-radius: 6px;
	box-shadow: inset 0 1px rgba(0, 0, 0, 0.02);
}
.switch-input:checked ~ .switch-handle {
	left: 50px;
	box-shadow: -1px 1px 5px rgba(0, 0, 0, 0.2);
}
 
/* Transition
========================== */
.switch-label, .switch-handle {
	transition: All 0.7s ease;
	-webkit-transition: All 0.7s ease;
	-moz-transition: All 0.7s ease;
	-o-transition: All 0.7s ease;
}

.divider{
    width:15px;
    height:auto;
    display:inline-block;
}

/*caseProcessCSS*/