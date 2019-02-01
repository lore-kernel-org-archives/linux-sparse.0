From: Thomas Garnier <thgarnie@google.com>
Subject: Re: [PATCH v6 15/27] compiler: Option to default to hidden symbols
Date: Fri, 1 Feb 2019 09:00:50 -0800
Message-ID: <CAJcbSZEhcKVBn0vOE0rkdwkf3vRmmZ=ttoJNfN4+20QTRTuSng@mail.gmail.com>
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-16-thgarnie@chromium.org>
 <20190201071259.GB14343@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190201071259.GB14343@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Thomas Garnier <thgarnie@chromium.org>, Kernel Hardening <kernel-hardening@lists.openwall.com>, kristen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Jason Baron <jbaron@akamai.com>, Jordan Borgner <mail@jordan-borgner.de>, Masami Hiramatsu <mhiramat@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
List-Id: linux-sparse@vger.kernel.org

On Thu, Jan 31, 2019 at 11:13 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Jan 31, 2019 at 11:24:22AM -0800, Thomas Garnier wrote:
> > Provide an option to default visibility to hidden except for key
> > symbols.
>
> It took me a while to figure out the verb in this sentence...  :P

I agree, I should rewrite this description.

>
> It's weird that we're annotating things to be default.  What visibility
> are they we leave off the annotation?

The word "default" is confusing but that's how it is called by gcc.
Symbols not marked default are hidden.

>
> regards,
> dan carpenter
>


-- 
Thomas
