From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 08:48:10 -0700
Message-ID: <1182959290.8970.59.camel@josh-work.beaverton.ibm.com>
References: <20070627103320.GA11047@localhost.sw.ru>
	 <1182956472.8970.35.camel@josh-work.beaverton.ibm.com>
	 <46827F4D.7010305@knosof.co.uk> <20070627153133.GD11047@localhost.sw.ru>
	 <4682836C.10201@knosof.co.uk>  <468285D1.1020506@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:48304 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890AbXF0PsP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 11:48:15 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5RFmEbv007621
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 11:48:14 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l5RFmC97196214
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 09:48:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l5RFmBOA029154
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 09:48:12 -0600
In-Reply-To: <468285D1.1020506@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Alexey Dobriyan <adobriyan@sw.ru>, linux-sparse@vger.kernel.org, adobriyan@gmail.com

On Wed, 2007-06-27 at 16:44 +0100, Derek M Jones wrote:
> All,
> 
> >>> The syntax permits:
> >>>
> >>> signed unsigned short long double int;
> >>
> >> Please, read 6.7.2(2).
> > 
> > Semantic spoil sport.
> 
> The point I did not mention before sending the email
> was the extent to which Sparse needs to check constructs
> that are constraint violations and thus assumed to be checked
> by the compiler.
> 
> Ok, it is possible to get weird looking stuff through sparse
> without complaint, but is it worth spending time flagging it?
> 
> Surely time should be concentrated on flagging suspicious constructs
> that are valid C and not in correctly handling obscure corners
> of the language.

Ideally, I would like Sparse to provide a self-contained set of
warnings, even those potentially redundant with a compiler.  However, I
agree that in general Sparse should give priority to issues that a
compiler will not already flag.

- Josh Triplett
