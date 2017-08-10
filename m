From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/2] Adding document for sparse patch submit process
Date: Thu, 10 Aug 2017 12:36:43 -0700
Message-ID: <3b19a3d1-83d0-ce26-e7fc-4fb87052c8bd@infradead.org>
References: <CANeU7Qm9+-++i6U9DYXn-NYVj-k4r63JkK3srESyboTxQiP=4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbdHJTgu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 15:36:50 -0400
In-Reply-To: <CANeU7Qm9+-++i6U9DYXn-NYVj-k4r63JkK3srESyboTxQiP=4g@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On 08/09/2017 08:27 PM, Christopher Li wrote:
> Reference to the linux kernel patches submitting process
> and difference to sparse.
> 
> Signed-off-by: Christopher Li <sparse@chrisli.org>
> ---
>  Documentation/submitting-patches.md | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/submitting-patches.md
> 
> diff --git a/Documentation/submitting-patches.md
> b/Documentation/submitting-patches.md
> new file mode 100644
> index 0000000..f526d44
> --- /dev/null
> +++ b/Documentation/submitting-patches.md
> @@ -0,0 +1,21 @@
> +Submitting patches: the sparse version
> +======================================
> +
> +Sparse use a patch submit process similar to the Linux Kernel

          uses

> +[Submitting Patches](https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html)
> +
> +This document mostly focus on the parts might be different from the Linux

                        focuses on the parts that might be

> +Kernel submitting process.
> +
> +1. Git clone a sparse repository:
> +
> +        git clone git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> +
> +2. [Coding Style](https://www.kernel.org/doc/html/v4.12/process/coding-style.html)
> remain the same.

  remains

> +
> +2. Sign off the patch.

3. instead of 2. ??

> +
> +   The usage of the Signed-off-by tag is the same as [Linux Kernel
> Sign your work](https://www.kernel.org/doc/html/v4.12/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin).
> +
> +   Notice that sparse is MIT License.

                  sparse uses the MIT License.

> +
> 


-- 
~Randy
