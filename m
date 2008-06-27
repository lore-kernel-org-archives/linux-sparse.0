From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: The __cold__ attribute again
Date: Fri, 27 Jun 2008 10:40:53 -0700
Message-ID: <1214588453.5189.0.camel@josh-work.beaverton.ibm.com>
References: <1214582459.6045.4.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:41223 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808AbYF0RlG (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jun 2008 13:41:06 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5RHf4Di013090
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 13:41:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m5RHeue5040448
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 13:40:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m5RHeu9C001469
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jun 2008 13:40:56 -0400
In-Reply-To: <1214582459.6045.4.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse <linux-sparse@vger.kernel.org>

On Fri, 2008-06-27 at 12:00 -0400, Pavel Roskin wrote:
> It would be nice to have a new release with the __cold__ attribute
> support in time for Linux 2.6.26 release, which uses __cold__ in some
> important headers, including linux/kernel.h.  Otherwise, sparse will be
> useless with the new kernel.

Will do.  Thanks for the heads-up.

- Josh Triplett


