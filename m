From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC][PATCH 0/3] implement pseudo->ctype
Date: Thu, 21 Jun 2012 03:00:51 -0700
Message-ID: <CANeU7Q=OHoLdD0O4o8tdcEoAjB83y+8G8mcZGuT2TduQooWkYA@mail.gmail.com>
References: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:50063 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759271Ab2FUKHu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 21 Jun 2012 06:07:50 -0400
Received: by gglu4 with SMTP id u4so289552ggl.19
        for <linux-sparse@vger.kernel.org>; Thu, 21 Jun 2012 03:07:49 -0700 (PDT)
In-Reply-To: <1338792878-25898-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sun, Jun 3, 2012 at 11:54 PM, Xi Wang <xi.wang@gmail.com> wrote:
> This patchset tries to implement Chris's `counter RFC': adding ->ctyp=
e
> to pseudo, while removing ->type and ->size from instruction. =A0In t=
his
> way, it provides easy access to type information for backend.

I like this series a lot. Do you have an update version of the patch?

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
