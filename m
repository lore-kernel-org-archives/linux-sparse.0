From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Documentation/sparse.txt: document context annotations
 for lock checking
Date: Fri, 19 Oct 2012 15:14:22 -0700
Message-ID: <CANeU7QkUdeR6HyDEVF1fkm9EN=SEkcuY0QPyZxpYnGAzDj7+kg@mail.gmail.com>
References: <1350570446.22036@cat.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350570446.22036@cat.he.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Cashin <ecashin@coraid.com>
Cc: akpm@linux-foundation.org, josh@joshtriplett.org, rob@landley.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, sam@ravnborg.org, ak@linux.intel.com
List-Id: linux-sparse@vger.kernel.org

On Thu, Oct 18, 2012 at 7:27 AM, Ed Cashin <ecashin@coraid.com> wrote:
> The context feature of sparse is used with the Linux kernel
> sources to check for imbalanced uses of locks.  Document the
> annotations defined in include/linux/compiler.h that tell sparse
> what to expect when a lock is held on function entry, exit, or
> both.
>
> Signed-off-by: Ed Cashin <ecashin@coraid.com>

Signed-off-by: Christopher Li <sparse@chrisli.org>

Chris
