From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] fix pointer casts in evaluate_compare()
Date: Sun, 19 May 2013 08:29:03 -0400
Message-ID: <CAKU6vyYFnZh73QHOqj=B_Bp4M_e706eGhM57w29pCfhaseNfAw@mail.gmail.com>
References: <1368737733-6475-1-git-send-email-xi.wang@gmail.com> <CAOJsxLEy3A72isV1OFL4rUm=B6Z659h1ZXsExSn9pzG2GSmukQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63996 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3ESM3o (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 May 2013 08:29:44 -0400
Received: by mail-ob0-f169.google.com with SMTP id vb8so6266294obc.14
        for <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 05:29:44 -0700 (PDT)
In-Reply-To: <CAOJsxLEy3A72isV1OFL4rUm=B6Z659h1ZXsExSn9pzG2GSmukQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sun, May 19, 2013 at 3:48 AM, Pekka Enberg <penberg@kernel.org> wrote:
> How did you find about this? Is this needed to fix a reproducible issue?

I was debugging like (p == 0) and noticed that sparse lost this cast
to pointers.

A more serious problem in evaluate_compare() is that sparse evaluates
comparisons to bool, which should have been int, according to the C
standard.

For example, sparse incorrectly evaluates sizeof(1 == 0) to 1, while
gcc and clang evaluate this to 4 (i.e., sizeof(int)).

Similar problems exist when sparse evaluates other conditional
expressions, such as !, &&, ||.

This also confuses sparse-llvm.  For example, given OP_AND_BOOL x, y,
should sparse-llvm assume that x and y can be int, bool, or some other
type?

- xi
