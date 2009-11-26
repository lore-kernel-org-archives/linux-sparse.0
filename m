From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Add more ignored attributes
Date: Wed, 25 Nov 2009 16:54:23 -0800
Message-ID: <70318cbf0911251654k234b88f6we5872915a470a40a@mail.gmail.com>
References: <200911251429.18554.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:30434 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754184AbZKZAyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Nov 2009 19:54:18 -0500
Received: by ey-out-2122.google.com with SMTP id 4so89404eyf.19
        for <linux-sparse@vger.kernel.org>; Wed, 25 Nov 2009 16:54:23 -0800 (PST)
In-Reply-To: <200911251429.18554.mb@bu3sch.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Buesch <mb@bu3sch.de>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Wed, Nov 25, 2009 at 5:29 AM, Michael Buesch <mb@bu3sch.de> wrote:
> + =A0 =A0 =A0 { "externally_visible", NS_KEYWORD, =A0 =A0 .op =3D &ig=
nore_attr_op },
> + =A0 =A0 =A0 { "__externally_visible__", =A0 =A0 NS_KEYWORD, =A0 =A0=
 .op =3D &ignore_attr_op },
> + =A0 =A0 =A0 { "signal", =A0 =A0 NS_KEYWORD, =A0 =A0 .op =3D &ignore=
_attr_op },
> + =A0 =A0 =A0 { "__signal__", NS_KEYWORD, =A0 =A0 .op =3D &ignore_att=
r_op },

Can you update your patch base on the chrisl branch?
git://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git

In the new code you just need to add the attribute name to ignored_attr=
ibutes
array.

Thanks

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
