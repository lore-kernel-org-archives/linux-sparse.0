From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Date: Mon, 28 Oct 2019 23:15:24 +0100
Message-ID: <20191028221523.vlzdk6dkcglxei6v@desk.local>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
 <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
 <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-sparse@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 28, 2019 at 10:59:47AM -0700, Joe Perches wrote:
> On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
> > Just in case: for these ones (i.e. __CHECKER__), did you check if
> > sparse handles this syntax? (I don't recall myself if it does).
> > 
> > Other than that, thanks for the cleanup too! I can pick it up in the
> > the compiler-attributes tree and put it in -next.
> 
> Thanks for asking and no, I did  not until just now.
> Turns out sparse does _not_ handle these changes and
> the checking fails for these __<changes>__.
> 
> sparse would have to update parse.c or the __CHECKER__
> changes would need to be reverted.
> 
> Perhaps update parse.c like:

...

Yes, this was missing. Thanks.
Can I have your SoB for this?

-- Luc
