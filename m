From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 16:24:12 +0000
Message-ID: <14efacd19a76488c8771b9781dec34c0@AcuMS.aculab.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Michael Matz' <matz@suse.de>, Segher Boessenkool <segher@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Richard Biener <rguenther@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

From: Michael Matz
> Sent: 07 October 2018 16:53
...
> I think the examples I saw from Boris were all indirect inlines:
> 
>   static inline void foo() { asm("large-looking-but-small-asm"); }
>   static void bar1() { ... foo() ... }
>   static void bar2() { ... foo() ... }
>   void goo (void) { bar1(); }  // bar1 should have been inlined
> 
> So, while the immediate asm user was marked as always inline that in turn
> caused users of it to become non-inlined.  I'm assuming the kernel guys
> did proper measurements that they _really_ get some non-trivial speed
> benefit by inlining bar1/bar2, but for some reasons (I didn't inquire)
> didn't want to mark them all as inline as well.

Could you add a 'size' attribute to the 'always inlined' foo() above
rather than trying to add one to the asm() statement itself.
Then add a warning in the documentation that small size attributes
might make the assembly fail due to limited branch offsets (etc).

Size '1' probably ought to be reserved for things that definitely
fit in a delay slot.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
