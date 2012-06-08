From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Fri, 8 Jun 2012 14:50:11 +0300
Message-ID: <CAOJsxLH2R+UtuEVt_uCkF+kSdk7XNzN-KCjekegUWM1dEzCh8Q@mail.gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:58046 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab2FHLuM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 8 Jun 2012 07:50:12 -0400
Received: by ghrr11 with SMTP id r11so1139510ghr.19
        for <linux-sparse@vger.kernel.org>; Fri, 08 Jun 2012 04:50:11 -0700 (PDT)
In-Reply-To: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christopher Li <sparse@chrisli.org>

On Mon, Jun 4, 2012 at 9:54 AM, Xi Wang <xi.wang@gmail.com> wrote:
> This patchset tries to implement Chris's `counter RFC': adding ->ctyp=
e
> to pseudo, while removing ->type and ->size from instruction. =A0In t=
his
> way, it provides easy access to type information for backend.

Could you please CC me on patches that touch Sparse/LLVM in the future?

The LLVM parts look good to me:

Acked-by: Pekka Enberg <penberg@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
