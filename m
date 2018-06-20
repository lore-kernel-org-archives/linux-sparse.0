From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/9] x86: macrofying inline asm for better compilation
Date: Wed, 20 Jun 2018 12:11:01 +0200
Message-ID: <20180620101101.GB2530@hirez.programming.kicks-ass.net>
References: <20180619194854.69486-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180619194854.69486-1-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christopher Li <sparse@chrisli.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Sam Ravnborg <sam@ravnborg.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-sparse@vger.kernel.org

On Tue, Jun 19, 2018 at 12:48:45PM -0700, Nadav Amit wrote:
> Nadav Amit (9):
>   Makefile: Prepare for using macros for inline asm
>   x86: objtool: use asm macro for better compiler decisions
>   x86: refcount: prevent gcc distortions
>   x86: alternatives: macrofy locks for better inlining
>   x86: bug: prevent gcc distortions
>   x86: prevent inline distortion by paravirt ops
>   x86: extable: use macros instead of inline assembly
>   x86: cpufeature: use macros instead of inline assembly
>   x86: jump-labels: use macros instead of inline assembly
> 
>  Makefile                               |  9 ++-
>  arch/x86/Makefile                      | 11 ++-
>  arch/x86/include/asm/alternative-asm.h | 20 ++++--
>  arch/x86/include/asm/alternative.h     | 11 +--
>  arch/x86/include/asm/asm.h             | 61 +++++++---------
>  arch/x86/include/asm/bug.h             | 98 +++++++++++++++-----------
>  arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++---------
>  arch/x86/include/asm/jump_label.h      | 65 ++++++++++-------
>  arch/x86/include/asm/paravirt_types.h  | 56 +++++++--------
>  arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
>  arch/x86/kernel/macros.S               | 16 +++++
>  include/asm-generic/bug.h              |  8 +--
>  include/linux/compiler.h               | 56 +++++++++++----
>  scripts/Kbuild.include                 |  4 +-
>  scripts/mod/Makefile                   |  2 +
>  15 files changed, 340 insertions(+), 233 deletions(-)
>  create mode 100644 arch/x86/kernel/macros.S

Aside from the one niggle:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
