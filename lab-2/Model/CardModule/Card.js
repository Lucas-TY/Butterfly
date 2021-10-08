/**
 * A class that represents a single card in the game Set.
 * 
 * @member {number} numShapes - number of shapes on the card
 * @member {string} shape - type of shape on the card
 * @member {srting} shading - type of shading of the shape
 * @member {string} color - color of the shape
 * @member {number} index - index of the card in a hand (or other collection)
 * @member {string} imageFile - filename of the corresponding image (use is optional)
 * 
 * @author Adam Lechliter
 */
class Card {

    /**
     * Initializes a new instance of a Card
     * @param  {number} numShapes - number of shapes for the card
     * @param  {string} shape - the type of shape on the card
     * @param  {string} shading - the type of shading of the shape
     * @param  {string} color - the color of the shape
     * 
     * @returns {Card} a new instance of a Card Object
     */
    constructor(numShapes, shape, shading, color) {
        const EMPTY_INDEX = 1;

        this.numShapes = numShapes;
        this.shading = shading;
        this.shape = shape;
        this.color = color;

        // Creates the image file name based on the properties of the card
        this.imageFile = `${color}_${shading}_${shape}_${numShapes}.png`;

        this.index = EMPTY_INDEX;

        /**
         * Changes the index of the card
         * 
         * @param {number} index - new index of the card
         * @returns void
         */
        this.setIndex = function (index = EMPTY_INDEX) {
            this.index = index;
        }
    }

    /**
     * Get the possible amounts of shapes for a set card
     * 
     * @returns {Array(number)} - array of the possible amounts of shapes possible for a card.
     */
    static getNumShapeTypes() {
        return [1, 2, 3];
    }

    /**
     * Get the possible shapes that can appear on a set card
     * 
     * @returns {Array(string)} - array of the possible shapes on a card
     */
    static getShapeTypes() {
        return ["diamond", "oval", "squiggle"];
    }

    /**
     * Get the possible shadings for shapes that can appear on a set card
     * 
     * @returns {Array(string)} - array of the possible shadings of a shape
     */
    static getShadingTypes() {
        return ["solid", "striped", "open"];
    }

    /**
     * Get the possible colors for shapes that can appear on a set card
     * 
     * @returns {Array(string)} - array of the possible colors of a shape
     */
    static getColorTypes() {
        return ["red", "green", "purple"];
    }

}