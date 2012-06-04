From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] check missing or duplicate goto labels
Date: Mon, 4 Jun 2012 16:10:43 -0700
Message-ID: <CANeU7QkToacKXoTUg60mbtvqoD0RzTHAUfp6zprD1BbZoiynxg@mail.gmail.com>
References: <1338753706-24520-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45862 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546Ab2FDXKo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jun 2012 19:10:44 -0400
Received: by wibhn6 with SMTP id hn6so3319735wib.1
        for <linux-sparse@vger.kernel.org>; Mon, 04 Jun 2012 16:10:43 -0700 (PDT)
In-Reply-To: <1338753706-24520-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Jun 3, 2012 at 1:01 PM, Xi Wang <xi.wang@gmail.com> wrote:
> This patch sets ->stmt of a SYM_LABEL to the corresponding label
> statement. =A0If ->stmt was already set, it is a duplicate label.
>
> On the other hand, if ->stmt of a goto label is not set during
> evaluation, the label was never declared.

Looks great! Can you please send me a signed off line?

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
