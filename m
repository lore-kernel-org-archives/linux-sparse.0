From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
Date: Fri, 21 Dec 2018 10:44:28 -0800
Message-ID: <87woo23ek3.fsf@linux.intel.com>
References: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
        (Masahiro Yamada's message of "Sun, 16 Dec 2018 11:50:32 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Richard Biener <rguenther@suse.de>, Nadav Amit <namit@vmware.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Michal Marek <michal.lkml@markovi.net>, linux-sparse@vger.kernel.org, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, linux-kbuild@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Revert the following 9 commits:

FWIW the -Wa additional also broke LTO builds because it doesn't really
support -Wa for individual files.

So I'm glad they got reverted.

-Andi
