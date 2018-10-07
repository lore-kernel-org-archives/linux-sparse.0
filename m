From: Jeff Law <law@redhat.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Sun, 7 Oct 2018 13:52:24 -0600
Message-ID: <0f93b80c-c7c1-0a85-9863-87a2a0dfd051@redhat.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic>
 <4F2F1BCE-7875-4160-9E1E-9F8EF962D989@vmware.com>
 <FC56B15B-0D4A-4A4A-81DA-A5093B56A210@suse.de>
 <56EB8A07-8D24-40F1-8CCE-614D7B712519@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56EB8A07-8D24-40F1-8CCE-614D7B712519@vmware.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <namit@vmware.com>, Richard Biener <rguenther@suse.de>, Borislav Petkov <bp@alien8.de>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Michael Matz <matz@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.li
List-Id: linux-sparse@vger.kernel.org

On 10/7/18 1:06 PM, Nadav Amit wrote:
> at 9:46 AM, Richard Biener <rguenther@suse.de> wrote:
> 
>> On October 7, 2018 6:09:30 PM GMT+02:00, Nadav Amit <namit@vmware.com> wrote:
>>> at 2:18 AM, Borislav Petkov <bp@alien8.de> wrote:
>>>
>>>> Hi people,
>>>>
>>>> this is an attempt to see whether gcc's inline asm heuristic when
>>>> estimating inline asm statements' cost for better inlining can be
>>>> improved.
>>>>
>>>> AFAIU, the problematic arises when one ends up using a lot of inline
>>>> asm statements in the kernel but due to the inline asm cost
>>> estimation
>>>> heuristic which counts lines, I think, for example like in this here
>>>> macro:
>>> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2Farch%2Fx86%2Finclude%2Fasm%2Fcpufeature.h%23n162&amp;data=02%7C01%7Cnamit%40vmware.com%7C860403cecb874db64b7e08d62c746f46%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636745275975505381&amp;sdata=Nd0636K9Z1IsUs1RWSRAhVuVboLxlBCB4peiAMfmQzQ%3D&amp;reserved=0
>>>> the resulting code ends up not inlining the functions themselves
>>> which
>>>> use this macro. I.e., you see a CALL <function> instead of its body
>>>> getting inlined directly.
>>>>
>>>> Even though it should be because the actual instructions are only a
>>>> couple in most cases and all those other directives end up in another
>>>> section anyway.
>>>>
>>>> The issue is explained below in the forwarded mail in a larger detail
>>>> too.
>>>>
>>>> Now, Richard suggested doing something like:
>>>>
>>>> 1) inline asm ("...")
>>>> 2) asm ("..." : : : : <size-expr>)
>>>> 3) asm ("...") __attribute__((asm_size(<size-expr>)));
>>>>
>>>> with which user can tell gcc what the size of that inline asm
>>> statement
>>>> is and thus allow for more precise cost estimation and in the end
>>> better
>>>> inlining.
>>>>
>>>> And FWIW 3) looks pretty straight-forward to me because attributes
>>> are
>>>> pretty common anyways.
>>>>
>>>> But I'm sure there are other options and I'm sure people will have
>>>> better/different ideas so feel free to chime in.
>>>
>>> Thanks for taking care of it. I would like to mention a second issue,
>>> since
>>> you may want to resolve both with a single solution: not inlining
>>> conditional __builtin_constant_p(), in which there are two code-paths -
>>> one
>>> for constants and one for variables.
>>>
>>> Consider for example the Linux kernel ilog2 macro, which has a
>>> condition
>>> based on __builtin_constant_p() (
>>> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv4.19-rc7%2Fsource%2Finclude%2Flinux%2Flog2.h%23L160&amp;data=02%7C01%7Cnamit%40vmware.com%7C860403cecb874db64b7e08d62c746f46%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636745275975515386&amp;sdata=Hk39Za9%2FxcFyK0sGENB24d6QySjsDGzF%2FwqjnUEMiGk%3D&amp;reserved=0
>>> ). The compiler mistakenly considers the “heavy” code-path that is
>>> supposed
>>> to be evaluated only in compilation time to evaluate the code size.
>>
>> But this is a misconception about __builtin_constant_p. It doesn't guard sth like 'constexpr' regions. If you try to use it with those semantics you'll fail (appearantly you do). 
>>
>> Of course IPA CP code size estimates when seeing a constant fed to bcp might be not optimal, that's another issue of course. 
> 
> I understand that this is might not be the right way to implement macros
> such as ilog2() and test_bit(), but this code is around for some time.
That doesn't make it right -- and there's been numerous bogus bugs
reported against ilog2 because the authors of ilog2 haven't had a clear
understanding of the semantics of builtin_constant_p.


Jeff
