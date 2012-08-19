From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] sparse, llvm: 'Verify' the LLVM module before writing it
Date: Sun, 19 Aug 2012 12:14:41 +0300
Message-ID: <CAOJsxLGJgTJx-w2UPKNRd=cMn-a4fiCJyTm9E-ahSD5T=AoZEg@mail.gmail.com>
References: <1345337422-22094-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:55411 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab2HSJOm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Aug 2012 05:14:42 -0400
Received: by weyx8 with SMTP id x8so3332539wey.19
        for <linux-sparse@vger.kernel.org>; Sun, 19 Aug 2012 02:14:41 -0700 (PDT)
In-Reply-To: <1345337422-22094-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 19, 2012 at 3:50 AM, Jonathan Neusch=E4fer
<j.neuschaefer@gmx.net> wrote:
> In later versions sparse-llvm should stop on wrong llvm code, instead
> of outputting it, but for now there are too many warnings being produ=
ced
> for this to be feasible (I think).
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>

Applied to 'llvm/core' branch:

https://github.com/penberg/sparse-llvm/commits/llvm/core

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
