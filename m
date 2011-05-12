From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] evaluate: Allow sizeof(_Bool) to succeed.
Date: Wed, 11 May 2011 17:09:42 -0700
Message-ID: <BANLkTinHEgDw24S=mcE6B7OeirrHk+ZSog@mail.gmail.com>
References: <1304552394-16280-1-git-send-email-blp@nicira.com>
	<BANLkTikHwADf5Kv5=rQosKcNjsMYM-28wQ@mail.gmail.com>
	<20110509200231.GG2971@nicira.com>
	<BANLkTim26gM+WxF+XSjZTVf+sL9xLLtCoA@mail.gmail.com>
	<20110509204937.GI2971@nicira.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33157 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab1ELAJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 11 May 2011 20:09:44 -0400
Received: by wya21 with SMTP id 21so782107wya.19
        for <linux-sparse@vger.kernel.org>; Wed, 11 May 2011 17:09:43 -0700 (PDT)
In-Reply-To: <20110509204937.GI2971@nicira.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ben Pfaff <blp@nicira.com>
Cc: linux-sparse@vger.kernel.org

On Mon, May 9, 2011 at 1:49 PM, Ben Pfaff <blp@nicira.com> wrote:
> The 'fault' member is 3-valued: a null pointer means that the row has
> an empty "fault" column; otherwise it points either to a malloc()'d
> true or false value. =A0The warning then crops up in the generated co=
de
> for populating this struct, which does something similar to the
> following when the "fault" column is nonempty:
>
> =A0 =A0row->fault =3D xmalloc(sizeof *row->fault);
> =A0 =A0*row->fault =3D /* value parsed from database row */;

I don't see particular things wrong with it. Personally I think malloc =
is
a bit overkill here. It will likely pad the area to natural machine int=
 size
any way.

> I could change my IDL code generator to do something different for
> this case, but I don't see anything actually wrong with it. =A0This
> userspace code is not performance-critical or sensitive to memory
> usage, so it's not necessary on the face of it to optimize it.

Removing the warning will lose the chance to see it on other potential
problematic usage. If you insist on no warning. You can submit a patch
to add a switch to disable it. We have a lot of those for fine grain wa=
rning
control. I just don't see this warning can hurt on the kernel checking =
side.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
