From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] unssa: track use of newly added pseudo
Date: Thu, 3 May 2012 13:31:24 -0700
Message-ID: <CANeU7Q=LaKEp4RAPKmJUCCYpYNrAVTLeP56LwOE2Gu9oKWUBCQ@mail.gmail.com>
References: <4FA29D3F.3000905@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63687 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753382Ab2ECUbZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 May 2012 16:31:25 -0400
Received: by ghrr11 with SMTP id r11so2201590ghr.19
        for <linux-sparse@vger.kernel.org>; Thu, 03 May 2012 13:31:24 -0700 (PDT)
In-Reply-To: <4FA29D3F.3000905@seznam.cz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: =?ISO-8859-1?Q?Jan_Pokorn=FD?= <pokorny_jan@seznam.cz>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, May 3, 2012 at 7:59 AM, Jan Pokorn=FD <pokorny_jan@seznam.cz> w=
rote:
> Currently, it is a completely "isolated island" from backend
> point of view as it also lacks pseudo->def information.

Thanks, applied.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
