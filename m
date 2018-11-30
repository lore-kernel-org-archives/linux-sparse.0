From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Fri, 30 Nov 2018 07:16:34 -0600
Message-ID: <20181130131633.GU23873@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <CAK7LNARmrdtyE7JRAdJH_zbfvD_cej+TGLh+5KfT20o538KUcA@mail.gmail.com> <20181129122500.GX23873@gate.crashing.org> <CF26ACBE-500C-47E8-B79D-E1ABE938031D@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197789-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <CF26ACBE-500C-47E8-B79D-E1ABE938031D@alien8.de>
To: Boris Petkov <bp@alien8.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, rguenther@suse.de, matz@suse.de, gcc@gcc.gnu.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>, P hilippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, vir
List-Id: linux-sparse@vger.kernel.org

On Fri, Nov 30, 2018 at 10:06:02AM +0100, Boris Petkov wrote:
> On November 29, 2018 1:25:02 PM GMT+01:00, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> >This will only be fixed from GCC 9 on, if the compiler adopts it.  The
> >kernel wants to support ancient GCC, so it will need to have a
> >workaround
> >for older GCC versions anyway.
> 
> What about backporting it, like Richard says?

Let me first get it into GCC trunk :-)

It should backport fine, sure; and I'll work on that.


Segher
