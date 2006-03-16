From: terra@gnome.org (Morten Welinder)
Subject: Re: case label types
Date: Wed, 15 Mar 2006 20:47:10 -0500 (EST)
Message-ID: <200603160147.k2G1lAc28952@troll.rentec.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from centaur.rentec.com ([216.223.240.8]:58575 "EHLO
	centaur.rentec.com") by vger.kernel.org with ESMTP id S1751990AbWCPBrW
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 15 Mar 2006 20:47:22 -0500
Received: from ram.rentec.com (ram [192.5.35.66])
	by centaur.rentec.com (8.13.1/8.12.1) with ESMTP id k2G1lLR0011457
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2006 20:47:22 -0500 (EST)
Received: from troll.rentec.com (IDENT:1@troll.rentec.com [192.5.35.34])
	by ram.rentec.com (8.13.1/8.12.1) with ESMTP id k2G1lA4P006636
	for <linux-sparse@vger.kernel.org>; Wed, 15 Mar 2006 20:47:10 -0500 (EST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


> I assume that in general we _do_ want the case/switch statements to have
> the same test as if you tested for equality explicitly.

I think so.

- case labels [vs the switch value and vs each other]

    switch (42) {
    case A1: ...;
    case b1: ...;
    }

- comparisons: =, <, ...

- (foo ? e1 : e2)

- function calls?

M.
