From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Sun, 14 Oct 2018 00:14:02 +0300 (MSK)
Message-ID: <alpine.LNX.2.20.13.1810132355180.13914@monopod.intra.ispras.ru>
References: <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de> <20181008073128.GL29268@gate.crashing.org> <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr> <20181009145330.GT29268@gate.crashing.org> <alpine.LSU.2.20.1810100909140.16707@zhemvz.fhfr.qr>
 <20181010072240.GB103159@gmail.com> <20181010080324.GV29268@gate.crashing.org> <20181010081906.GA5533@zn.tnic> <20181010185432.GB29268@gate.crashing.org> <20181010191427.GF5533@zn.tnic> <20181013193335.GD31650@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181013193335.GD31650@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Ingo Molnar <mingo@kernel.org>, Richard Biener <rguenther@suse.de>, Michael Matz <matz@suse.de>, gcc@gcc.gnu.org, Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, linux-sparse@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-sparse@vger.kernel.org

Hi,

On Sat, 13 Oct 2018, Borislav Petkov wrote:
> 
> Thoughts, suggestions, etc are most welcome.

I apologize for coming in late here with an alternative proposal, but would
you be happy if GCC gave you a way to designate a portion of the asm template
string that shouldn't be counted as its cost because it doesn't go into the
.text section? This wouldn't interact with your redefinitions of the inline
keyword, and you could do something like (assuming we go with %` ... %`
delimiters)

[if gcc-9 or compatible]

#define ASM_NONTEXT_START "%`\n"
#define ASM_NONTEXT_END   "%`\n"

[else]

#define ASM_NONTEXT_START "\n"
#define ASM_NONTEXT_END   "\n"

[endif]

#define _BUG_FLAGS(ins, flags)						\
do {									\
	asm volatile("1:\t" ins "\n"					\
	             ASM_NONTEXT_START                                  \
		     ".pushsection __bug_table,\"aw\"\n"		\
		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
		     "\t.org 2b+%c1\n"					\
		     ".popsection"					\
	             ASM_NONTEXT_END                                    \
		     : : "i" (flags),					\
			 "i" (sizeof(struct bug_entry)));		\
} while (0)


I think it's nicer because it also allows the compiler to estimate asm length
for branch range optimization more accurately.

Alexander
