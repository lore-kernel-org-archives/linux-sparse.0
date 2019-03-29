From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 3/4] x86/fpu: Fix __user annotations
Date: Fri, 29 Mar 2019 19:42:08 +0000
Message-ID: <20190329194208.GE2217@ZenIV.linux.org.uk>
References: <20190329163047.223508-1-jannh@google.com>
 <20190329163047.223508-3-jannh@google.com>
 <20190329180329.hl3t7a43sg3sshsf@ltop.local>
 <CAG48ez2+AeBuJ8i8RKL3THc1Nq1_vPyqLTXep8CvJgqVtGYCig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAG48ez2+AeBuJ8i8RKL3THc1Nq1_vPyqLTXep8CvJgqVtGYCig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jann Horn <jannh@google.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Qiaowei Ren <qiaowei.ren@intel.com>
List-Id: linux-sparse@vger.kernel.org

On Fri, Mar 29, 2019 at 08:25:25PM +0100, Jann Horn wrote:
> Oooh, it's a sparse bug.

It's *not* a bug.  

> Apparently it's significant that the user pointer is stored as a
> __u64, and __u64 is defined as unsigned long long.

Yes, it is.  Casts to uintptr_t (== unsigned long on all targets)
are OK; any other arithmetical type gives a warning, and quite
deliberately so.

Don't do it.  If you want to say "I'm converting it to integer,
all traces of its origin are gone", use an idiomatic cast.
