From: Josh Triplett <josh@kernel.org>
Subject: Re: strict aliasing warnings in Sparse; -fno-strict-aliasing
Date: Thu, 06 Sep 2007 11:26:58 -0700
Message-ID: <1189103218.23348.1.camel@josh-work.beaverton.ibm.com>
References: <46DA522C.4010209@freedesktop.org>
Reply-To: josh@kernel.org, josht@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:35174 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755803AbXIFS1T (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 6 Sep 2007 14:27:19 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l86IShqw001780
	for <linux-sparse@vger.kernel.org>; Thu, 6 Sep 2007 14:28:43 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id l86IRIFr650560
	for <linux-sparse@vger.kernel.org>; Thu, 6 Sep 2007 14:27:18 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l86IRIZu023354
	for <linux-sparse@vger.kernel.org>; Thu, 6 Sep 2007 14:27:18 -0400
Received: from josh-work.beaverton.ibm.com (josh-work.beaverton.ibm.com [9.47.18.117])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l86IRH7E023327
	for <linux-sparse@vger.kernel.org>; Thu, 6 Sep 2007 14:27:18 -0400
In-Reply-To: <46DA522C.4010209@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Sat, 2007-09-01 at 23:03 -0700, Josh Triplett wrote:
> In the absence of a better suggestion, I intend to make Sparse use
> -fno-strict-aliasing.

I've changed the Sparse Makefile to use -fno-strict-aliasing.  Patches
welcome if someone wants to remove it and fix the warnings some other
way.

- Josh Triplett
