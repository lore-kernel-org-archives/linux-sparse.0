From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] validation/sizeof-bool: fix broken test case
Date: Mon, 3 Mar 2014 21:02:55 -0800
Message-ID: <CANeU7Q=V9C5ypZYiJYexuayExhUVq3ntRS1LCPTKCQLKRHBsqQ@mail.gmail.com>
References: <82beef733be057586c0c1b08c78ef1c585e17d46.1393763519.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:39105 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbaCDFCz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 4 Mar 2014 00:02:55 -0500
Received: by mail-qc0-f177.google.com with SMTP id w7so4772579qcr.22
        for <linux-sparse@vger.kernel.org>; Mon, 03 Mar 2014 21:02:55 -0800 (PST)
In-Reply-To: <82beef733be057586c0c1b08c78ef1c585e17d46.1393763519.git.john@keeping.me.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 2, 2014 at 4:31 AM, John Keeping <john@keeping.me.uk> wrote:
> Since commit 2667c2d (sparse: Allow override of sizeof(bool) warning,
> 2014-02-26) the default has been not to warn on sizeof(bool).  This
> means that the sizeof-bool test case now needs an explicit command in
> order to trigger the warning it is testing.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Thanks for the good catch. Will apply.

Chris
