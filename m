From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: specifying custom attributes
Date: Thu, 2 Aug 2007 23:41:51 -0400
Message-ID: <200708022341.51682.rgetz@blackfin.uclinux.org>
References: <8bd0f97a0708021553m6edaefccof086012f64b199a3@mail.gmail.com> <1186102384.3081.39.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:44487 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbXHCDiC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Aug 2007 23:38:02 -0400
In-Reply-To: <1186102384.3081.39.camel@josh-work.beaverton.ibm.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Mike Frysinger <vapier.adi@gmail.com>, linux-sparse@vger.kernel.org

On Thu 2 Aug 2007 20:53, Josh Triplett pondered:
> On Thu, 2007-08-02 at 18:53 -0400, Mike Frysinger wrote:
> > the Blackfin port has a few custom gcc attributes that annoys sparse:
> > include/asm/uaccess.h:63:77: error: attribute 'l1_text': unknown
> attribute
> > 
> > is there a way from the cmdline to specify a custom list of OK
> > attributes ?  i feel like adding these processor-specific attributes
> > to the source code may not be the way you guys wish to go ...
> 
> Currently no.  It might make sense to add a way to turn off the "unknown
> attribute" warning, like GCC's -Wno-attributes.

I'm not sure that helps. (if it is just a global turn it off).

We would like :
 - (a) not to get false assertions (when 'l1_text' is used)
 - to get proper assertions when:
    - (b) someone does a typo (when 'l1_test' is used)
    - (c) compiled on a system which doesn't support this (like x86) 
          to make sure we didn't polute anything we should not have

Adding things to the source will cause c to fail.
using something like -Wno-attributes will cause b to fail (unless you were 
thinking it would take a list on the command line)

-Wno-attributes foo,bar,l1_text

?

-Robin
