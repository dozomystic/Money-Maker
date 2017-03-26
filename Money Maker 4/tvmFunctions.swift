//
//  tvmFunctions.swift
//  Money Maker 4
//
//  Created by cedric tape on 3/24/17.
//  Copyright © 2017 cedric tape. All rights reserved.
//

import Foundation

class tvmFunctions {
	//http://www.tvmcalcs.com/tvm/formulas/annuity_due_formulas
	
	var PV: Double
	var FV: Double
	var PMT: Double
	var R: Double
	var NPER: Double
	var DUE: Bool

	init(PV: Double, FV: Double, PMT: Double, R: Double, NPER: Double, DUE: Bool) {
		self.PV = PV
		self.FV = FV
		self.PMT = PMT
		self.R = R
		self.NPER = NPER
		self.DUE = DUE
	}
	
	// Functions that take in a set of varianbles and calculate the missing variable requested
	func solvePV()-> Double{
		switch (DUE){
			case false: return pvLumpSum() + pvAnnuity()
			default: return pvLumpSum() + pvAnnuityDue()
		}
	}
	func solveFV()-> Double{
		switch (DUE){
			case false: return fvLumpSum() + fvAnnuity()
			default: return fvLumpSum() + fvAnnuityDue()
		}
	}
	func solvePMT()-> Double{
		switch (DUE){
			case false: return pmtPV() + pmtFV()
			default: return pmtPVAnnuityDue() + pmtFVAnnuityDue()
		}
	}
	func solvePeriod(){
		switch (DUE){
			case false: return NperPV() + NperFV() + NperLumpSum()
			default: return NperPVAnnuityDue() + NperFVAnnuityDue() + NperLumpSum()
		}
	}
	
	func pvLumpSum()-> Double{
		return FV/pow(1+R,NPER)
	}
	func pvAnnuity()-> Double{
		return PMT*((1-(1/pow(1+R,NPER)))/R)
	}
	func pvAnnuityDue()-> Double{
		return PMT*((1-(1/pow(1+R,NPER-1)))/R) + PMT
	}
	
	func fvLumpSum()-> Double{
		return PV*pow(1+R,NPER)
	}
	func fvAnnuity()-> Double{
		return PMT*((pow(1+R,NPER)-1)/R)
	}
	func fvAnnuityDue()-> Double{
		return PMT*((pow(1+R,NPER)-1)/R) * (1+R)
	}
	
	func pmtPV()-> Double{
		return PV/((1-(1/pow(1+R,NPER)))/R)
	}
	func pmtFV()-> Double{
		return FV/((pow(1+R,NPER)-1)/R)
	}
	func pmtPVAnnuityDue()-> Double{
		return FV/(((1-(1/pow(1+R,NPER-1)))/R) + 1)
	}
	func pmtFVAnnuityDue()-> Double{
		return FV/(((pow(1+R,NPER)-1)/R) * (1+R))
	}
	
	func NperPV()-> Double{
		return
	}
	func NperFV()-> Double{
		return
	}
	func NperLumpSum()-> Double{
		return
	}
	func NperPVAnnuityDue()-> Double{
		return
	}
	func NperFVAnnuityDue()-> Double{
		return
	}

}
