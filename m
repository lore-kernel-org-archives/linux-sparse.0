From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 1/2] sparse, llvm: improve pointer arithmetic handling
Date: Sun, 19 May 2013 15:49:58 +0300
Message-ID: <CAOJsxLErGy=US5DoegZWVHupHjCA=83MXXY2WOTmH0-wrJccmA@mail.gmail.com>
References: <1368965590-6714-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:64720 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab3ESMt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 May 2013 08:49:59 -0400
Received: by mail-wi0-f179.google.com with SMTP id hq7so1396666wib.6
        for <linux-sparse@vger.kernel.org>; Sun, 19 May 2013 05:49:58 -0700 (PDT)
In-Reply-To: <1368965590-6714-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, May 19, 2013 at 3:13 PM, Xi Wang <xi.wang@gmail.com> wrote:
> Converting pointers to integers for pointer arithmetic effectively
> disables pointer analysis and future optimizations.  A better way is =
to
> use LLVM's GEP, by converting pointers to `char *' rather than intege=
rs.
>
> Cc: Pekka Enberg <penberg@kernel.org>
> Acked-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Applied both patches, thanks a lot Xi!
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
