From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 15/27] compiler: Option to default to hidden symbols
Date: Fri, 1 Feb 2019 10:12:59 +0300
Message-ID: <20190201071259.GB14343@kadam>
References: <20190131192533.34130-1-thgarnie@chromium.org>
 <20190131192533.34130-16-thgarnie@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-hardening-return-15073-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Content-Disposition: inline
In-Reply-To: <20190131192533.34130-16-thgarnie@chromium.org>
To: Thomas Garnier <thgarnie@chromium.org>
Cc: kernel-hardening@lists.openwall.com, kristen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Jason Baron <jbaron@akamai.com>, Thomas Garnier <thgarnie@google.com>, Jordan Borgner <mail@jordan-borgner.de>, Masami Hiramatsu <mhiramat@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.o>
List-Id: linux-sparse@vger.kernel.org

On Thu, Jan 31, 2019 at 11:24:22AM -0800, Thomas Garnier wrote:
> Provide an option to default visibility to hidden except for key
> symbols.

It took me a while to figure out the verb in this sentence...  :P

It's weird that we're annotating things to be default.  What visibility
are they we leave off the annotation?

regards,
dan carpenter
