From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Sparse tool
Date: Thu, 17 Jul 2008 14:58:48 -0700
Message-ID: <1216331928.4870.7.camel@josh-work.beaverton.ibm.com>
References: <68f510a70807111259l5d15f385pec54c099d3960423@mail.gmail.com>
	 <20080711200829.GA26676@uranus.ravnborg.org>
	 <20080711201140.GA26723@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:40335 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbYGQV6s (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Jul 2008 17:58:48 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6HLwlrp010930
	for <linux-sparse@vger.kernel.org>; Thu, 17 Jul 2008 17:58:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m6HLwkjv166726
	for <linux-sparse@vger.kernel.org>; Thu, 17 Jul 2008 15:58:46 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m6HLwkl8016925
	for <linux-sparse@vger.kernel.org>; Thu, 17 Jul 2008 15:58:46 -0600
In-Reply-To: <20080711201140.GA26723@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Krishna Gopal <linuxkrishna@gmail.com>, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Fri, 2008-07-11 at 22:11 +0200, Sam Ravnborg wrote:
> On Fri, Jul 11, 2008 at 10:08:29PM +0200, Sam Ravnborg wrote:
> > On Fri, Jul 11, 2008 at 02:59:46PM -0500, Krishna Gopal wrote:
> > > Hi,
> > > 
> > >     I am running the sparse tool on my code and I see following error
> > > 
> > > error: too many arguments for function <noident>
> > > 
> > > Do any one know the reason behind this error ?
> > 
> > sparce mailing list added.
> This time with the correct address.

Can you please provide the code you used to trigger this error?  Or even
better, can you provide a test case which reproduces the error?

- Josh Triplett


