From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Add const to pointer qualifiers for __chk_user_ptr and __chk_io_ptr.
Date: Mon, 26 Mar 2007 11:46:56 -0700
Message-ID: <20070326184656.GB24841@chrisli.org>
References: <ee9e417a0703260823k55c6de8ay715be1db11692355@mail.gmail.com> <20070326180155.GA24764@chrisli.org> <ee9e417a0703261159g6aeed343t58a98c5f45141c53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc14.comcast.net ([204.127.225.94]:48342 "EHLO
	alnrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbXCZT0Y (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 26 Mar 2007 15:26:24 -0400
Content-Disposition: inline
In-Reply-To: <ee9e417a0703261159g6aeed343t58a98c5f45141c53@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Russ Cox <rsc@swtch.com>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Mon, Mar 26, 2007 at 02:59:39PM -0400, Russ Cox wrote:
> No, you have it backward.
> It is valid to pass void* to a const void* function.
> It is *not* valid to pass const void* to a void* function.
> 
> Right now __chk_user_ptr is a void* function, meaning
> that all the places where it gets passed a const void*
> are technically illegal -- gcc would warn about these, and
> it is a (separate, as you observed) bug that sparse does not.
> 
> The patch changes __chk_user_ptr to be a const void*
> function, meaning that it will be legal to pass either void*
> or const void* to it.  This is the correct semantics.

Hah, I see. Thanks for the explain.

Ack.

Chris
