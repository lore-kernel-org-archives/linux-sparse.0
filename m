From: Josh Triplett <josh@freedesktop.org>
Subject: Re: [PATCH] switch to hash-based get_one_special()
Date: Tue, 24 Oct 2006 08:42:34 -0700
Message-ID: <453E346A.1010203@freedesktop.org>
References: <20061001185502.GA29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:59045 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965159AbWJXPmh (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 24 Oct 2006 11:42:37 -0400
In-Reply-To: <20061001185502.GA29920@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>, linux-sparse@vger.kernel.org

Al Viro wrote:
> Weird, but true: the set of C two-character punctuators and
> two-symbol prefices of three-character punctuators is
> distinguishable by 5-bit hash function (27 out of 32).
> Application is obvious - we get much faster get_one_special()
> out of that...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>
> [and now all patches older than a month are gone]
> 
>  token.h    |   18 +++++++-------
>  tokenize.c |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 75 insertions(+), 21 deletions(-)

Added to my sparse tree at:
git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git

Thanks,
Josh Triplett
