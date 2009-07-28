From: Christopher Li <sparse@chrisli.org>
Subject: Re: Detect unused header files?
Date: Tue, 28 Jul 2009 13:49:57 -0700
Message-ID: <70318cbf0907281349k72a71b8fyc10d80992e4b1db9@mail.gmail.com>
References: <20090728181803.GA20845@merkur.ravnborg.org>
	 <70318cbf0907281336p47b68b5cg44a3e7206646cb80@mail.gmail.com>
	 <alpine.LFD.2.00.0907281634400.3974@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:62323 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743AbZG1Ut6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 28 Jul 2009 16:49:58 -0400
Received: by qyk9 with SMTP id 9so246164qyk.33
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jul 2009 13:49:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0907281634400.3974@localhost>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: Sam Ravnborg <sam@ravnborg.org>, sparse <linux-sparse@vger.kernel.org>

On Tue, Jul 28, 2009 at 1:36 PM, Robert P. J. Day<rpjday@crashcourse.ca=
> wrote:
> sure you can. =A0no one should be counting on the inclusion of header
> files by other header files (except possibly in unusual situations,
> which i can't even think of at the moment). =A0if your program needs =
the
> contents of a header file, it's your responsibility to include it.

The case I have in mind is that, some API level header file include som=
e
internal header file for constant defines. For example:

drivers/ieee1394/host.h include drivers/ieee1394/csr.h.

The "csr.h" is just the register define. It is not used in this header =
file
itself. I did not check very closely, for augments sake pretend those
inline function are not there. It just have register defines.

Should the C program changed to include "csr.h" directly? I don't think=
 so.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
