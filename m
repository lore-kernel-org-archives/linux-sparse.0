Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06F1C5481;
	Fri,  6 Dec 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514152; cv=none; b=kyDVp9yakKFOj07Uz9miBMS6vuvWzn1j63/z0n3c4GcRQHMK1k+0GsbxXRuIDGoTnJcCqUIK2D0Siv+BvMqbSWCDGHzYFGwawAe+LzuMZkNbDm/o9lF9oNW0LXEvE/I++eSGWD1ZkvDg5L3FT9oXvdoDzFtQRb0aKxA09PKkcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514152; c=relaxed/simple;
	bh=al8af9LUoZpdbTVawRb9oJInscz4Tf9QiIkefhSAAfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ge2n72ML143tzGJiktZs5LlV+m508E1wdyRsJUsqLC4+1ZAr4ExnxlybEVpRBbmSKEfEulZ+Xbatmc+sF0oogeJmzhof/5DxH4v8A/pyu98uSGPaJv6Mpndd19sXZyirXVeQnCfzYXFFQgHYMMp/34UKTlWguKIzw/eLgyZNaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 4B6JcarQ027033;
	Fri, 6 Dec 2024 20:38:36 +0100
Date: Fri, 6 Dec 2024 20:38:36 +0100
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tursulin@ursulin.net>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "uecker@tugraz.at" <uecker@tugraz.at>
Subject: Re: [PATCH 02/10] compiler.h: add is_const() as a replacement of
 __is_constexpr()
Message-ID: <20241206193836.GA26860@1wt.eu>
References: <20241203-is_constexpr-refactor-v1-0-4e4cbaecc216@wanadoo.fr>
 <20241203-is_constexpr-refactor-v1-2-4e4cbaecc216@wanadoo.fr>
 <1d807c7471b9434aa8807e6e86c964ec@AcuMS.aculab.com>
 <CAMZ6RqLJLP+4d8f5gLfBdFeDVgqy23O+Eo8HRgKCthqBjSHaaw@mail.gmail.com>
 <9ef03cebb4dd406885d8fdf79aaef043@AcuMS.aculab.com>
 <CAHk-=wjmeU6ahyuwAymqkSpxX-gCNa3Qc70UXjgnxNiC8eiyOw@mail.gmail.com>
 <CAMZ6Rq+SzTA25XcMZnMnOJcrrq1VZpeT1xceinarqbXgDDo8VA@mail.gmail.com>
 <CAHk-=wiP8111QZZJNbcDNsYQ_JC-xvwRKr0qV9UdKn3HKK+-4Q@mail.gmail.com>
 <d23fe8a5dbe84bfeb18097fdef7aa4c4@AcuMS.aculab.com>
 <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=win8afdcergvJ6f2=rRrff8giGUW62qmYs9Ae6aw=wcnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Dec 06, 2024 at 11:15:20AM -0800, Linus Torvalds wrote:
> On Fri, 6 Dec 2024 at 11:07, David Laight <David.Laight@aculab.com> wrote:
> >
> > I'm missing the compiler version and options to generate the error.
> 
> Just -Wall with most recent gcc versions seems to do it. At least I
> can repro it with gcc-14.2.1 and something silly like this:
> 
>   $ cat t.c
>   int fn(int a) { return (a<<2)?1:2; }
>   $ gcc -Wall -S t.c
>   t.c: In function 'fn':
>   t.c:1:26: warning: '<<' in boolean context, did you mean '<'?
> [-Wint-in-bool-context]
> 
> > Does a '+ 0' help?  "(var << 2) + 0 ? 0 : 0"
> 
> Yeah, that actually works.
> 
> And "+0" is nice in that it should work in any context.

I've already used "+0" to shut certain warnings, I don't really remember
which one, but also remember it was OK everywhere I needed.

Another trick I've been using to shut up the compiler is a cast via typeof
and an intermediary variable:

  #define shut_up(expr)                           \
          ({                                      \
                  typeof(expr) _expr_ = expr;     \
                  _expr_;                         \
                  })
  
  int fn1(int a)
  {
          return shut_up(a << 2) ? 1 : 2;
  }
  
  int fn2(int a)
  {
          return (a << 2) ? 1 : 2;
  }

  $ gcc -Wall -S t2.c
  t2.c: In function 'fn2':
  t2.c:15:19: warning: '<<' in boolean context, did you mean '<'? [-Wint-in-bool-context]
     15 |         return (a << 2) ? 1 : 2;
        |                ~~~^~~~~

See ? It only complains on fn2() but not fn1(). Similarly I found it
to be quite portable (at least I don't remember seeing it fail on me).
It produces the exact same code, except at -O0 where it does really
create a local variable.

Willy
