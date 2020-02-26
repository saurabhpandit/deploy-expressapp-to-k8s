const assert = require('assert');
const mocha = require('mocha');
const expect = require('chai').expect;
const request = require('supertest');
const { name } = require('../../package.json')

const app = require('../app');

describe('Unit tests for /version', function() {
    
    it('should return OK', async function() {
        const res = await request(app)
            .get('/version');
        assert.equal(res.status, 200);
    });

    it('should return desc, version, lastcommitsha', async function() {
        const res = await request(app)
            .get('/version');
        expect(res.body).to.be.an('object');
        expect(res.body).to.have.property(name).that.is.an('array');
        
        let appData = res.body[name];
        expect(appData).to.have.lengthOf(1)
        
        expect(appData[0]).to.have.property('version');
        expect(appData[0]).to.have.property('description');
        expect(appData[0]).to.have.property('lastcommitsha');
    });
});
