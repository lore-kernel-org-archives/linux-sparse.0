From: Ingo Molnar <mingo@kernel.org>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Mon, 8 Oct 2018 07:58:38 +0200
Message-ID: <20181008055838.GA66819@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <20181007132228.GJ29268@gate.crashing.org>
 <20181007141349.GD30687@zn.tnic>
 <20181007151427.GK29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181007151427.GK29268@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Borislav Petkov <bp@alien8.de>, gcc@gcc.gnu.org, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Th
List-Id: linux-sparse@vger.kernel.org


* Segher Boessenkool <segher@kernel.crashing.org> wrote:

> > > More precise *size* estimates, yes.  And if the user lies he should not
> > > be surprised to get assembler errors, etc.
> > 
> > Yes.
> > 
> > Another option would be if gcc parses the inline asm directly and
> > does a more precise size estimation. Which is a lot more involved and
> > complicated solution so I guess we wanna look at the simpler ones first.
> > 
> > :-)
> 
> Which is *impossible* to do.  Inline assembler is free-form text.

"Impossible" is false: only under GCC's model and semantics of inline
asm that is, and only under the (false) assumption that the semantics
of the asm statement (which is a GCC extension to begin with) cannot
be changed like it has been changed multiple times in the past.

"Difficult", "not worth our while", perhaps.

Thanks,

	Ingo
