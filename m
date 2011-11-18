From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Reduced call graph
Date: Fri, 18 Nov 2011 08:14:55 +0700
Message-ID: <CACsJy8BDYEx4-G2G-PEL3Q69pdBWwndE=Uyx5rV-pYPg570ZOA@mail.gmail.com>
References: <CACsJy8A2X0WukKXerJAN6pxARoGSh1O=8FM+iTZL-xzDCQ1W=w@mail.gmail.com>
 <CANeU7Qns9GDx=XtiEzBph-3gq7WKX+uZMyVu7y3GETzAenFEVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33032 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1KRBPa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 17 Nov 2011 20:15:30 -0500
Received: by bke11 with SMTP id 11so2795480bke.19
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2011 17:15:29 -0800 (PST)
In-Reply-To: <CANeU7Qns9GDx=XtiEzBph-3gq7WKX+uZMyVu7y3GETzAenFEVg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Hi,

On Fri, Nov 18, 2011 at 5:12 AM, Christopher Li <sparse@chrisli.org> wr=
ote:
> In order to find out all the call graphs, you need to at least run
> very file in sparse. Then for each function, after linearization, you
> can find out all the "call" instruction. A easier but not so precise
> way is examine the "access" list in the entry point. That will
> include every symbol rather than just function called.
>
> e.g.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct entrypo=
int *ep;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pseudo_t p;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0expand_symbol(=
sym);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ep =3D lineari=
ze_symbol(sym);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FOR_EACH_PTR(e=
p->accesses, p) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0printf(" =C2=A0 pseudo: %p type %d %s\n", p, p->type, sho=
w_pseudo(p));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} END_FOR_EACH=
_PTR(p);
>
> You just filter out the non-function symbols. However you need to wri=
te
> some code to do that recursively.

Thanks. Can I trace function callbacks too? I think it involves
keeping track of callbacks until they are called..
--=20
Duy
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
