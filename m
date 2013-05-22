From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH] lib: rename die_if_error to error_happened
Date: Wed, 22 May 2013 09:49:10 +0300
Message-ID: <CAOJsxLEpzPpO7NCh+ED2bi+WF99g6O==A64=oxX1HXizNnoyVg@mail.gmail.com>
References: <1369154944-11352-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:56668 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab3EVGtL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 May 2013 02:49:11 -0400
Received: by mail-wi0-f169.google.com with SMTP id hn14so3777913wib.0
        for <linux-sparse@vger.kernel.org>; Tue, 21 May 2013 23:49:10 -0700 (PDT)
In-Reply-To: <1369154944-11352-1-git-send-email-j.neuschaefer@gmx.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Xi Wang <xi.wang@gmail.com>

On Tue, May 21, 2013 at 7:49 PM, Jonathan Neusch=E4fer
<j.neuschaefer@gmx.net> wrote:
> The variable in question is set when an error message is output,
> and doesn't control termination at all, so I think the new name
> matches the semantics better.
>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: Xi Wang <xi.wang@gmail.com>
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>

Chris, are you OK with me picking this up in the sparse-llvm tree?
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
