From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH] parse.c: Adding va_end().
Date: Fri, 27 Jul 2007 10:22:01 -0700
Message-ID: <1185556921.2642.9.camel@josh-work.beaverton.ibm.com>
References: <1185492502.46a92e16f26bf@portal.student.luth.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:54848 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbXG0RVh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 27 Jul 2007 13:21:37 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l6RGFYtO015671
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jul 2007 12:15:34 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6RHLaxE259048
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jul 2007 11:21:36 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6RHLZN6023857
	for <linux-sparse@vger.kernel.org>; Fri, 27 Jul 2007 11:21:36 -0600
In-Reply-To: <1185492502.46a92e16f26bf@portal.student.luth.se>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ricknu-0@student.ltu.se
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-07-27 at 01:28 +0200, ricknu-0@student.ltu.se wrote:
> Adding va_end().
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> ---
> According to the manual, it needs a va_end() in the same function.
> Now it seems to be as many of va_end() as va_start().

Applied; thanks.

- Josh Triplett
