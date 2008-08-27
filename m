From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH] don't call sparse when called to generate dependencies
Date: Tue, 26 Aug 2008 17:43:04 -0700
Message-ID: <1219797784.6911.9.camel@josh-work.beaverton.ibm.com>
References: <1219700019-19627-1-git-send-email-alexander.shishckin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:44552 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbYH0Am5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Aug 2008 20:42:57 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7R0gtvq021076
	for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 20:42:55 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id m7R0gt4g201406
	for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 18:42:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m7R0gtAd015517
	for <linux-sparse@vger.kernel.org>; Tue, 26 Aug 2008 18:42:55 -0600
In-Reply-To: <1219700019-19627-1-git-send-email-alexander.shishckin@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexander Shishkin <alexander.shishckin@gmail.com>
Cc: sparse development list <linux-sparse@vger.kernel.org>

On Tue, 2008-08-26 at 00:33 +0300, Alexander Shishkin wrote:
> I have a situation here when $(CC) is called with -M options with
> slighly different set of -I/-D/etc arguments, which causes all sorts of
> funny reports from sparse. Also, this increases the overall build time
> because every compilation unit if sparsed twice.

Makes sense, given that -M implies -E.  Applied, thanks.

- Josh Triplett


