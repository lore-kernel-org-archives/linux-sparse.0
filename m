From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 5] Adding the NULL pointer checker.
Date: Tue, 16 Jan 2007 18:41:30 -0800
Message-ID: <20070117024130.GH962@chrisli.org>
References: <20070117023918.GF962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([206.18.177.54]:53729 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbXAQDEr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 22:04:47 -0500
Content-Disposition: inline
In-Reply-To: <20070117023918.GF962@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

Oops, this should be [PATCH 6] instead.

Chris

On Tue, Jan 16, 2007 at 06:39:18PM -0800, Christopher Li wrote:
> 
> Changelog:
>  - Using pseudo user list to find out the calling function.
>    It doesn't scan instruction one by one any more.
> 
> This patch add the kmalloc null pointer checking. It also
> try to track the double free as well. It knows a few kmalloc like
> functions and kfree etc.
> 
> The interrupt checking is just a toy. Without cross function checking,
> it is way too many false positive. 
> 
> Signed-off-by: Christopher Li<sparse@chrisli.org>
> 
