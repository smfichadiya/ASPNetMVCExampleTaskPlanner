"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/* WritersSigniture
//Writer: Angelo Sanches (BitSan)(Git:TheTrueTrooper)
//Date Writen: June 23,2017
//Project Goal: Make a cloud based app to aid in project management
//File Goal: To make a reusable graph base to extend
//Link: https://github.com/TheTrueTrooper/AngelASPExtentions
//Sources:
//  {
//  Name: TypeScript
//  Writer/Publisher: Microsoft
//  Link: https://www.typescriptlang.org/
//  }
*/
var BasicVectors = require("../Code/BasicVectors");
var js3D = require("../TypeDeffs/3Djs");
var Graphing;
(function (Graphing) {
    var Graph = /** @class */ (function () {
        function Graph(finder) {
            // should it render on any change
            this._RerenderOnChange = true;
            // to overload it should be set to OverloadRender with a void typodis
            // it should do the main render you could also draw axis here
            // wish I could type define this more but you cant function type or else I dont know how :'0 really should have one if you want to extend
            this._VirtalRender = null;
            // the canvas box and the parents box
            this._CanvasParent = js3D.select(finder);
            this._Canvas = this._CanvasParent.append("svg");
            // get the size of the graph
            this._Size = new BasicVectors.Vector2D(Number(this._CanvasParent.attr("Width")), Number(this._CanvasParent.attr("Hieght")));
            this._Canvas
                .attr("width", this._Size.X)
                .attr("hieght", this._Size.Y);
            // set the basic start
            this._Origin = new BasicVectors.Vector2D(0, 0);
            // rest per graph after
            this._UnitPxScale = new BasicVectors.Vector2D(0, 0);
        }
        // Set the origin to draw from
        Graph.prototype.SetOrigin = function (x, y) {
            this._Origin = new BasicVectors.Vector2D(x, y);
            if (this._RerenderOnChange)
                this.Render();
        };
        // Set the scale
        Graph.prototype.SetOriginV = function (Location) {
            this._Origin = Location;
            if (this._RerenderOnChange)
                this.Render();
        };
        // Set the scale
        Graph.prototype.SetScale = function (x, y) {
            this._UnitPxScale = new BasicVectors.Vector2D(x, y);
            if (this._RerenderOnChange)
                this.Render();
        };
        // Set the scale
        Graph.prototype.SetScaleV = function (Scale) {
            this._UnitPxScale = Scale;
            if (this._RerenderOnChange)
                this.Render();
        };
        // Sets the size
        Graph.prototype.SetSize = function (x, y) {
            this._Size = new BasicVectors.Vector2D(x, y);
            this._Canvas
                .attr("width", this._Size.X)
                .attr("hieght", this._Size.Y);
            if (this._RerenderOnChange)
                this.Render();
        };
        // Set the size
        Graph.prototype.SetSizeV = function (Size) {
            this._Size = Size;
            if (this._RerenderOnChange)
                this.Render();
        };
        // Retruns the size
        Graph.prototype.GetSize = function () {
            return this._Size;
        };
        // Returns the orgin to draw at
        Graph.prototype.GetOrigin = function () {
            return this._Origin;
        };
        // Gets the parent
        Graph.prototype.GetParent = function () {
            return this._CanvasParent;
        };
        // Called to call the virtual Render or a Non-virtual interface pattern INV call system for use in rendering
        Graph.prototype.Render = function () {
            this._VirtalRender();
        };
        // Clears out the rendered nodes so that you dcan redre
        Graph.prototype.ClearRender = function () {
            // Get the canvas node and clear it
            var CanvNode = this._Canvas.node();
            while (CanvNode.childNodes.length > 0) {
                CanvNode.removeChild(CanvNode.firstChild);
            }
        };
        // Used like a deconstructor Call this and return it to your reffernce to the object for GC.
        Graph.prototype.KillThis = function () {
            this._CanvasParent.node().removeChild(this._Canvas.node());
            this._Canvas = null;
            return null;
        };
        return Graph;
    }());
    Graphing.Graph = Graph;
})(Graphing = exports.Graphing || (exports.Graphing = {}));
//# sourceMappingURL=Graph.js.map