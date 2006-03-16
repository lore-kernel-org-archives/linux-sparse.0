From: terra@gnome.org (Morten Welinder)
Subject: case label types
Date: Wed, 15 Mar 2006 20:07:11 -0500 (EST)
Message-ID: <200603160107.k2G17Bo25114@troll.rentec.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from centaur.rentec.com ([216.223.240.8]:28363 "EHLO
	centaur.rentec.com") by vger.kernel.org with ESMTP id S1751849AbWCPBH0
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Mar 2006 20:07:26 -0500
Received: from ram.rentec.com (ram [192.5.35.66])
	by centaur.rentec.com (8.13.1/8.12.1) with ESMTP id k2G17OC0010310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2006 20:07:25 -0500 (EST)
Received: from troll.rentec.com (IDENT:1@troll.rentec.com [192.5.35.34])
	by ram.rentec.com (8.13.1/8.12.1) with ESMTP id k2G17Ctc003941
	for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2006 20:07:12 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Shouldn't sparse complain over this kind of code, or does it have
legitimate uses?

Specifically, enum constants from two different enums occur in the
same switch.

Morten


-----------------------------------------------------------------------------

typedef enum { A1, A2 } enumA;
typedef enum { B1 = 10, B2 } enumB;

int
main (int argc, char **argv)
{
  switch (A1) {
  case A1: break;
  case A2: break;
  case B1: break;
  case B2: break;
  default: break;
  }
  return 0;
}
