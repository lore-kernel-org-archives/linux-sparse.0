From: Dan Carpenter <error27@gmail.com>
Subject: Re: typedefs and alignment
Date: Wed, 10 Feb 2010 13:11:48 +0300
Message-ID: <20100210101148.GD14210@bicker>
References: <20100208103501.GA14210@bicker> <70318cbf1002100146r4b1ae748ida389c688d3fc4ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56782 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028Ab0BJKMB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Feb 2010 05:12:01 -0500
Received: by vws20 with SMTP id 20so75010vws.19
        for <linux-sparse@vger.kernel.org>; Wed, 10 Feb 2010 02:11:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <70318cbf1002100146r4b1ae748ida389c688d3fc4ce@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Li <christ.li@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Feb 10, 2010 at 01:46:39AM -0800, Chris Li wrote:
> On Mon, Feb 8, 2010 at 2:35 AM, Dan Carpenter <error27@gmail.com> wro=
te:
> > I've found an issue handling typedefs and alignment. =A0In the appe=
nded
> > code sparse things 'ptr' has to be aligned so the size of 'bar' is =
1024.
> > I haven't looked at how to fix this at all, I thought I would ask t=
he
> > experts for hints first.
>=20
> Can you try this one line patch?
>=20

Works great.  Thanks so much.

regards,
dan carpenter

> Thanks
>=20
> Chris


--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
