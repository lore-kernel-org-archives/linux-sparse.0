From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 05:02:46 -0500
Message-ID: <20181008100245.GP29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197356-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
To: Richard Biener <rguenther@suse.de>
Cc: Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@n>, exb.com, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundatio
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 08, 2018 at 11:07:46AM +0200, Richard Biener wrote:
> > All of a targets register names and alternative register names are
> > allowed in the clobber list.  Will that never conflict with an attribute
> > name?  We already *have* syntax for specifying attributes on an asm (on
> > *any* statement even), so mixing these two things has no advantage.
> 
> Heh, but I failed to make an example with attribute synatx working.
> IIRC attributes do not work on stmts.  What could work is to use
> a #pragma though.

Apparently statement attributes currently(?) only work for null statements.
Oh well.


Segher
