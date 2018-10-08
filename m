From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 02:53:00 -0500
Message-ID: <20181008075300.GN29268@gate.crashing.org>
References: <20181003213100.189959-1-namit@vmware.com> <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org> <20181007141349.GD30687@zn.tnic> <20181007151427.GK29268@gate.crashing.org> <20181008055838.GA66819@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gcc-return-197353-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcg-devel-2=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Content-Disposition: inline
In-Reply-To: <20181008055838.GA66819@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

On Mon, Oct 08, 2018 at 07:58:38AM +0200, Ingo Molnar wrote:
> * Segher Boessenkool <segher@kernel.crashing.org> wrote:
> > > > More precise *size* estimates, yes.  And if the user lies he should not
> > > > be surprised to get assembler errors, etc.
> > > 
> > > Yes.
> > > 
> > > Another option would be if gcc parses the inline asm directly and
> > > does a more precise size estimation. Which is a lot more involved and
> > > complicated solution so I guess we wanna look at the simpler ones first.
> > > 
> > > :-)
> > 
> > Which is *impossible* to do.  Inline assembler is free-form text.
> 
> "Impossible" is false: only under GCC's model and semantics of inline
> asm that is, and only under the (false) assumption that the semantics
> of the asm statement (which is a GCC extension to begin with) cannot
> be changed like it has been changed multiple times in the past.
> 
> "Difficult", "not worth our while", perhaps.

If we throw out our current definition of inline assembler, and of the
internal backend interfaces, then sure you can do it.  This of course
invalidates all code that uses GCC inline assembler, and all GCC backends
(both in-tree and out-of-tree, both current and historical).

If other compilers think everyone should rewrite all of their code because
those compiler do inline asm wro^H^H^Hdifferently, that is their problem;
GCC should not deny all history and screw over all its users.


Segher
