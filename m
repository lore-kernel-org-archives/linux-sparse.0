From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: specifying custom attributes
Date: Thu, 02 Aug 2007 17:53:04 -0700
Message-ID: <1186102384.3081.39.camel@josh-work.beaverton.ibm.com>
References: <8bd0f97a0708021553m6edaefccof086012f64b199a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:37401 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759221AbXHCAwe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Aug 2007 20:52:34 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l730qXt1014847
	for <linux-sparse@vger.kernel.org>; Thu, 2 Aug 2007 20:52:33 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l730qXNq173070
	for <linux-sparse@vger.kernel.org>; Thu, 2 Aug 2007 18:52:33 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l730qXom008054
	for <linux-sparse@vger.kernel.org>; Thu, 2 Aug 2007 18:52:33 -0600
In-Reply-To: <8bd0f97a0708021553m6edaefccof086012f64b199a3@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: linux-sparse@vger.kernel.org, Robin Getz <rgetz@blackfin.uclinux.org>

On Thu, 2007-08-02 at 18:53 -0400, Mike Frysinger wrote:
> the Blackfin port has a few custom gcc attributes that annoys sparse:
> include/asm/uaccess.h:63:77: error: attribute 'l1_text': unknown attribute
> 
> is there a way from the cmdline to specify a custom list of OK
> attributes ?  i feel like adding these processor-specific attributes
> to the source code may not be the way you guys wish to go ...

Currently no.  It might make sense to add a way to turn off the "unknown
attribute" warning, like GCC's -Wno-attributes.

- Josh Triplett
