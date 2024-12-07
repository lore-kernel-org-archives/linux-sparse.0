Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5CBBA49;
	Sat,  7 Dec 2024 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733576850; cv=none; b=UX7CDvvQiBilQZ+EgMtgRu+2HBnmgqk1vP0SxnfOsOPqVBUlaZKwyzR8UtkAjXPXkEeSyZgnG1Ont1ULoATWKv1PFZprXhsaKBZvtWHYWJhyFtZKS1cJbSR019gZk813dvnZsSOFIm86It4an0Z7H+lxOBFe+LIR6axFUPRTL5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733576850; c=relaxed/simple;
	bh=fOYGJZfgk0YynlbEA5Sp+VYIW2sBwcX+hdhV7N1wLtQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G0RMBLVSn0VADt87k4dV+UwhU4u3hOAtDv/vsqVjwNjhmj1Vs5Mz0eFArk85RhM5uoWpc+Rhb3NNASfdYXQJzzQXTi7+Z1c7ed1QYazbVJe1HvpbcWZAPSX2nqIj1AldYBsAFWNypZU8D781kqhZlTnpG9M/p6ZoZuPo5t17yqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gwdg.de; spf=pass smtp.mailfrom=gwdg.de; dkim=pass (2048-bit key) header.d=gwdg.de header.i=@gwdg.de header.b=e2Qd1tAB; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gwdg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gwdg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwdg.de header.i=@gwdg.de header.b="e2Qd1tAB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gwdg.de;
	s=2023-rsa; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:CC:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/uO1DmifJTy9zLn5kLoz0yWzTcVA7p32pVfQJYIukvo=; b=e2Qd1tABJB3so0uW5yOeFNTh2m
	bAgdqHapE4ARaSqoPh0wuuYfkFJiN6fzQw25oMXqezvMZhvs8kwWkdhWJqA9wx2m+4uh5kl3iXXWR
	qD1BX8N+9Bgie0PF2OleNUfi3Pzu330Smp9qtupvT+WFdjA4vpNd3x/Xo+pidd75LM2IrPPoiH1GB
	j1+KANv8/8ZEscTVeL/Qrri3V1yz1nuRxuKe1Po4Gs3OK6ceQg9+p8OdFsiFDULdOuMsi2j2hC3oZ
	Kfqzp1Os0LeI/3TSUiX2jy6rjZ0u8HpCdthdsHmWuIN/14fGhDhA8pFyO8Q9kdyTPMQYM4NuQwuzi
	mi5Ys46A==;
Received: from xmailer.gwdg.de ([134.76.10.29]:50730)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <muecker@gwdg.de>)
	id 1tJuWk-004M5Z-0k;
	Sat, 07 Dec 2024 14:07:18 +0100
Received: from mbx19-fmz-06.um.gwdg.de ([10.108.142.65] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
	(GWDG Mailer)
	(envelope-from <muecker@gwdg.de>)
	id 1tJuWk-000UX0-0P;
	Sat, 07 Dec 2024 14:07:18 +0100
Received: from [192.168.0.221] (10.250.9.200) by MBX19-FMZ-06.um.gwdg.de
 (10.108.142.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.14; Sat, 7 Dec
 2024 14:07:16 +0100
Message-ID: <9a0c041b6143ba07c2b3e524572fccd841f5374b.camel@gwdg.de>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
From: Martin Uecker <muecker@gwdg.de>
To: David Laight <David.Laight@ACULAB.COM>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck
	<luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jani Nikula
	<jani.nikula@linux.intel.com>, Joonas Lahtinen
	<joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Rikard Falkeborn
	<rikard.falkeborn@gmail.com>, "linux-sparse@vger.kernel.org"
	<linux-sparse@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "coresight@lists.linaro.org"
	<coresight@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Date: Sat, 7 Dec 2024 14:07:08 +0100
In-Reply-To: <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
	 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
	 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
	 <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
	 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
	 <abdd7862f136aa676b2d2c324369f4a43ff9909c.camel@gwdg.de>
	 <CAMZ6RqKzGiRNMeLsQKRNrxvW_bXB-kEi11udQ82kKX6tGCrqcg@mail.gmail.com>
	 <9607300dfca5d71ca9570b1e1de0864e524f356b.camel@gwdg.de>
	 <344b4cf41a474377b3d2cbf6302de703@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: MBX19-FMZ-04.um.gwdg.de (10.108.142.63) To
 MBX19-FMZ-06.um.gwdg.de (10.108.142.65)
X-EndpointSecurity-0xde81-EV: v:7.9.17.458, d:out, a:y, w:t, t:5, sv:1733541190, ts:1733576838
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Am Samstag, dem 07.12.2024 um 10:33 +0000 schrieb David Laight:
> From: Martin Uecker
> > Sent: 07 December 2024 08:40
> ...
> > I find it amazing how much time the Linux kernel community spends
> > revising code to make it work perfectly.
> >=20
> > Still, I am wondering whether some of this time and effort should not
> > be targeted at C compilers and language work to make these macro
> > hacks unnecessary?
>=20
> I'm probably not alone in thinking that sometimes the compiler writers
> are doing their hardest to make life hard for people writing low level co=
de.

GCC and Clang are open-source projects just like the kernel. One can=C2=A0
go there and contribute.  I am not saying that it is always easy to
find consensus and there also projects that have other requirements
than the kernel. But I started to contribute to GCC (with very limited
time) to address some of my own issues, and I found the community very
welcoming.

>=20
> > I already found the original motivation for these macros very questiona=
ble.
> > Removing VLAs at the cost having imprecise worst-case bounds strikes
> > me as fundamentally misguided - at least if security is the motivation.
>=20
> VLA basically cannot be allowed because of the very limited stack space.
> Even the per-frame limits aren't a real solution - they just catch the
> places that most likely to cause issues. Very deep call chains and any
> recursion (that isn't tightly bounded) can cause grief.

VLA use *less* stack than a fixed size arrays with fixed bound.
>=20
> > So maybe there are other good reasons for this, e.g. bad code
> > for VLAs or risk of jumping the guard page if the attacker can somehow
> > influence its size (but for this there is -Wvla-larger-than). But even =
then,
> > wouldn't it be a more worthwhile and interesting investment of engineer=
ing
> > resources to improving code generation / warnings at the compiler level=
?
>=20
> This is kernel code, any access into a stack guard page is basically
> unrecoverable for the entire system - a kernel lock/mutex could be held.
>
> With a list of (calling_fn, called_fn, stack_offset) it is possible
> calculate an accurate maximum stack usage.
> Indirect calls would need to use the (IIRC) FINE_IBT hashes to identify
> the possible functions (and I'm not sure than has an attribute for a 'see=
d'
> so that 'int (*)(void *)' functions can be separated into groups.
> I've not looked at whether objtool could generate the output - but is has
> to be easier for the compiler to do it.
>=20
> I have done that calculation in the past (parsing a compiler listing file=
)
> and basically discovered the system didn't actually have enough memory
> to allocate 'safe' stacks! The max stack was pretty much always (the
> equivalent of) printf() inside an error path that never happens.
> It might be interesting to see how bad linux is (after sorting out
> how to handle recursive calls - hopefully there won't be too many
> unexpected ones.

Compiler and ISO C language support to guarantee bounded stack usage
would indeed be a very interesting feature.

>=20
> > Also the fortification of strlen and co seems something which could be
> > much better solved with annotations and proper compiler support.
>=20
> That might be nice, but kernel have to be buildable with relatively
> old compilers.

Yes, but it could make use of it at some point in the future (or
optionally).

> Some things might need language/ABI changes to better handle ptr+size.
> The ability to return such a pair in registers would probably be useful
> (without doing horrid games with a union and __int128).

ptr + size is something we are looking into.

You can already do quite a bit by using C99's syntax for variably modified
types. For example, you would get UBSan trap for the following OOB access:

int foo(int n, char (*buf)[n])
{
  (*buf)[n] =3D 1;
}

This does not require an ABI change.=20

Martin




