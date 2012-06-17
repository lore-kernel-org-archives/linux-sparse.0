From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [RFC][PATCH] fix casting constant to _Bool
Date: Sun, 17 Jun 2012 14:44:09 -0400
Message-ID: <CAC8CFBE-2ED0-430F-98AD-65DB45CFCD25@gmail.com>
References: <1339829720-2069-1-git-send-email-xi.wang@gmail.com> <CA+55aFwTyqQ5WBL7b8fbCeBhM_sumQXc-SaKSzwOcwk431Vf9g@mail.gmail.com> <20120616165941.GG4400@mwanda> <CA+55aFxAJ7QSJNn9WeQBNjkRH7_NK=p=esXqZ=05Ndd_dxzYnQ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47225 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473Ab2FQSoV (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 17 Jun 2012 14:44:21 -0400
Received: by obbtb18 with SMTP id tb18so7300103obb.19
        for <linux-sparse@vger.kernel.org>; Sun, 17 Jun 2012 11:44:20 -0700 (PDT)
In-Reply-To: <CA+55aFxAJ7QSJNn9WeQBNjkRH7_NK=p=esXqZ=05Ndd_dxzYnQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Jun 16, 2012, at 1:20 PM, Linus Torvalds wrote:
> Maybe something like "Odd constant _Bool cast (%lld -> 1)"? It will
> always result in 1, since the only value that results in 0 is 0 (and
> isn't odd).

Sounds good.  I will send a v2.

- xi
