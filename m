From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Warnings while compiling sparse
Date: Mon, 30 Jul 2007 14:24:25 -0700
Message-ID: <1185830665.3334.27.camel@josh-work.beaverton.ibm.com>
References: <20070730203027.GA21099@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:32933 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967257AbXG3VYA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 30 Jul 2007 17:24:00 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6ULNwh9019810
	for <linux-sparse@vger.kernel.org>; Mon, 30 Jul 2007 17:23:58 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6ULNwJ5200394
	for <linux-sparse@vger.kernel.org>; Mon, 30 Jul 2007 15:23:58 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6ULNvwn030953
	for <linux-sparse@vger.kernel.org>; Mon, 30 Jul 2007 15:23:58 -0600
In-Reply-To: <20070730203027.GA21099@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: josh@freedesktop.org, linux-sparse@vger.kernel.org

On Mon, 2007-07-30 at 22:30 +0200, Michael Stefaniuc wrote:
> Hell Josh,

Hello to you too. :)

> commit 06bcf19cb8eb3cc3154ba6131477d742a9f0b4b6
> Author: Josh Triplett <josh@freedesktop.org>
> Date:   Sun Jul 29 20:20:38 2007 -0700
> 
>     Makefile: Use -O2 -finline-functions, not just -O
> 
>     introduces warnings while compiling sparse on my machine (FC6, x86,
>     gcc version 4.1.2 20070626 (Red Hat 4.1.2-13)):

Yes, it does here too.  All of this comes from the ptrlist code, which
does indeed break the C99 strict-aliasing rules in its pointer casts.
Either we need -fno-strict-aliasing or we need to type-pun through a
union; we most likely want the latter, though it'll uglify the ptrlist
code.

- Josh Triplett
