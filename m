From: Thomas Graf <tgraf@suug.ch>
Subject: Re: [PATCH] sparse: Fix ioc type check
Date: Thu, 25 Sep 2014 13:30:58 +0100
Message-ID: <20140925123058.GI4966@casper.infradead.org>
References: <8d1bffcadf496f52dc70063986684762344da771.1411633200.git.tgraf@suug.ch>
 <CANeU7Qkg9zBUoggGLBtFq6_-Svh9C2XHsFKdqvQ3TGaGNMZ79w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:47283 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbaIYMbC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Sep 2014 08:31:02 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7Qkg9zBUoggGLBtFq6_-Svh9C2XHsFKdqvQ3TGaGNMZ79w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, hans.verkuil@cisco.com

On 09/25/14 at 08:10pm, Christopher Li wrote:
> No, this test case is some thing gcc can handle and sparse
> can't. Instead of patching the test result, we need to fix sparse
> to handle it correctly.
> 
> It is an open bug of sparse.

OK. This was not clear from the commit message.
Thanks for clarifying.
