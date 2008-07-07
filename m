From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: Updated byte size patch
Date: Mon, 07 Jul 2008 11:02:50 -0700
Message-ID: <1215453770.3003.32.camel@josh-work.beaverton.ibm.com>
References: <487019DF.10907@cowlark.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:40608 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754209AbYGGSDA (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 7 Jul 2008 14:03:00 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m67I5JnL007771
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 14:05:19 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m67I2nCq183168
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 14:02:49 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m67I2moO017285
	for <linux-sparse@vger.kernel.org>; Mon, 7 Jul 2008 14:02:48 -0400
In-Reply-To: <487019DF.10907@cowlark.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: David Given <dg@cowlark.com>
Cc: linux-sparse@vger.kernel.org

On Sun, 2008-07-06 at 02:03 +0100, David Given wrote:
> Turns out that I'd missed one place where there was a hardcoded 8 in the
> last patch, so here's an updated version.

I do still have some concerns about the potential performance loss, but
it seems unlikely to cause a serious problem.  I have *serious* doubts
that Sparse will ever successfully handle a system without 8-bit bytes.
However, I will merge this patch.  I do need a signoff, though.

- Josh Triplett


